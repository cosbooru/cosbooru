# frozen_string_literal: true

require "shellwords"

# @see Source::URL::Youtube
class Source::Extractor::Youtube < Source::Extractor

  class Error < StandardError; end

  def image_urls
    if video?
      [page_url.to_s]
    elsif parsed_url.full_image_url.present?
      [parsed_url.full_image_url]
    elsif parsed_url.image_url?
      [parsed_url.to_s]
    elsif community_post_id.present?
      # A community post with multiple images has "postMultiImageRenderer"; a post with a single image doesn't.
      # Single image: https://www.youtube.com/post/UgkxWevNfezmf-a7CRIO0haWiaDSjTI8mGsf
      # Multiple images: https://www.youtube.com/post/UgkxBkJE1Eu_6S9sADZF5IuK5MPRSWf4VVz3
      attachments = community_post.dig("backstageAttachment", "postMultiImageRenderer", "images") || [community_post["backstageAttachment"]].compact
      attachments.map do |attachment|
        url = attachment.dig("backstageImageRenderer", "image", "thumbnails", 0, "url")
        Source::URL.parse(url).try(:full_image_url) || url
      end.compact
    else
      []
    end
  end

  def profile_url
    handle_url || channel_url
  end

  def profile_urls
    [handle_url, channel_url].compact
  end

  def display_name
    if video?
      video[:channel] || video[:uploader]
    else
      community_post.dig("authorText", "runs", 0, "text")
    end
  end

  def username
    handle
  end

  def tags
    if video?
      video[:tags].map do |tag|
        [ tag, "https://www.youtube.com/#{tag}"]
      end
    else
      community_post.dig(:contentText, :runs).to_a.filter_map do |run|
        url = run.dig(:navigationEndpoint, :commandMetadata, :webCommandMetadata, :url)&.then { |u| Danbooru::URL.unescape(u) }
        next unless url&.starts_with?("/hashtag/")

        [url.delete_prefix("/hashtag/"), "https://www.youtube.com#{url}"]
      end
    end
  end

  def artist_commentary_title
    video[:title] if video?
  end

  def artist_commentary_desc
    if video?
      video[:description]
    else
      community_post[:contentText]&.to_json
    end
  end

  def dtext_artist_commentary_desc
    if video?
      DText.from_plaintext(video[:description])
    else
      DText.from_html(html_artist_commentary_desc, base_url: "https://www.youtube.com")
    end
  end

  def html_artist_commentary_desc
    community_post.dig(:contentText, :runs).to_a.map do |run|
      text = CGI.escapeHTML(run[:text].to_s).gsub("\r\n", "\n").gsub("\r", "").normalize_whitespace.gsub("\n", "<br>")
      url = run.dig(:navigationEndpoint, :commandMetadata, :webCommandMetadata, :url)

      if url&.starts_with?("/")
        url = Danbooru::URL.unescape(url)
        %{<a href="https://www.youtube.com#{CGI.escapeHTML(url)}">#{text}</a>}
      elsif url&.starts_with?("https://www.youtube.com/redirect")
        %{<a href="#{text}">#{text}</a>}
      else
        "<span>#{text}</span>"
      end
    end.join
  end

  def download_file!(url)
    if !video?
      return super(url)
    end

    vcodec = video.dig(:video, :codec)
    acodec = video.dig(:audio, :codec)

    raise Error, "Unsupported video codec: #{vcodec}" unless vcodec.in?(["h264", "vp9"])
    raise Error, "Unsupported audio codec: #{acodec}" unless acodec.in?(["aac", "opus"])
    raise Error, "Incompatible codecs: #{vcodec} + #{acodec}" unless video.dig(:video, :ext) == video.dig(:audio, :ext)

    vresponse, vfile = http_downloader.download_file(video.dig(:video, :url))
    aresponse, afile = http_downloader.download_file(video.dig(:audio, :url))

    res = Danbooru::Tempfile.new(["danbooru-video-merge-#{parsed_url.video_id}", ".#{video.dig(:video, :ext)}"])

    ffmpeg_out, status = Open3.capture2e("ffmpeg -i #{vfile.path.shellescape} -i #{afile.path.shellescape} -c copy -y #{res.path.shellescape}")
    raise Error, "ffmpeg failed: #{ffmpeg_out}" unless status.success?

    MediaFile.open(res)
  ensure
    vfile&.close
    afile&.close
  end

  def community_post_id
    # parsed_url may be a Source::URL::Google instead of Source::URL::Youtube, which is why we use
    # `parsed_url.try(:post_id)` instead of `parsed_url.post_id` (`try` won't fail if the method doesn't exist).
    #
    # This happens when uploading lh*.googleusercontent.com album cover URLs. *.googleusercontent.com URLs are
    # handled by Source::URL::Google instead of Source::URL::Youtube because they're not used just by Youtube.
    parsed_url.try(:post_id) || parsed_referer.try(:post_id)
  end

  def channel_id
    if video?
      video[:channel_id]
    else
      parsed_url.try(:channel_id) || parsed_referer.try(:channel_id) || community_post.dig("authorEndpoint", "browseEndpoint", "browseId")
    end
  end

  def handle
    # "/@Mirae_Somang" -> "Mirae_Somang"
    if video?
      video[:uploader_id]&.delete_prefix("@")
    else
      parsed_url.try(:handle) || parsed_referer.try(:handle) || community_post.dig("authorEndpoint", "browseEndpoint", "canonicalBaseUrl")&.delete_prefix("/@")
    end
  end

  def channel_url
    "https://www.youtube.com/channel/#{channel_id}" if channel_id.present?
  end

  def handle_url
    "https://www.youtube.com/@#{handle}" if handle.present?
  end

  def video?
    parsed_url.video_id.present?
  end

  memoize def page
    http.cache(1.minute).parsed_get(page_url) if community_post_id.present?
  end

  memoize def community_post_json
    page&.at('script[text()*="ytInitialData"]')&.text&.slice(/{.*}/)&.parse_json || {}
  end

  memoize def video
    YtClient.new.info(:youtube, parsed_url.video_id) if video?
  end

  memoize def community_post
    community_post_json.dig(
      "contents", "twoColumnBrowseResultsRenderer", "tabs", 0, "tabRenderer", "content", "sectionListRenderer",
      "contents", 0, "itemSectionRenderer", "contents", 0, "backstagePostThreadRenderer", "post", "backstagePostRenderer"
    ) || {}
  end
end
