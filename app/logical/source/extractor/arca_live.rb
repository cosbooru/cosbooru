# frozen_string_literal: true

# @see https://arca.live
# @see Source::URL::ArcaLive
module Source
  class Extractor
    class ArcaLive < Source::Extractor
      def image_urls
        if parsed_url.image_url?
          [parsed_url.full_image_url]
        else
          image_urls_from_commentary
        end
      end

      def image_urls_from_commentary
        urls = artist_commentary_desc.to_s.parse_html.css("img:not(.arca-emoticon), video:not(.arca-emoticon)")&.to_a&.filter_map do |element|
          extract_image_url(element)
        end
      end

      def extract_image_url(element)
        url = element.attr("data-originalurl") || element.attr("src")
        url = "https:#{url}" if url.starts_with?("//")
        url = Source::URL.parse(url)

        if url.full_image_url.present?
          url.full_image_url
        elsif url.candidate_full_image_urls.present? && element["data-orig"].present?
          url.candidate_full_image_urls.find { |u| Source::URL.parse(u).file_ext == element["data-orig"] && http_exists?(u) } || url.to_s
        else
          url.candidate_full_image_urls.find { |u| http_exists?(u) } || url.to_s
        end
      end

      def profile_url
        # We do it like this we can handle users like https://arca.live/u/@크림/55256970 or https://arca.live/u/@Nauju/45320365
        url = page&.css(".member-info > .user-info > a")&.attr("href")
        Addressable::URI.join("https://arca.live", CGI.unescape(url)).to_s if url.present?
      end

      def artist_name
        page&.css(".member-info > .user-info > a")&.text
      end

      def artist_commentary_title
        page&.css(".title-row > .title")&.children&.last&.text&.strip
      end

      def artist_commentary_desc
        page&.css(".article-content")&.to_s
      end

      def dtext_artist_commentary_desc
        DText.from_html(artist_commentary_desc, base_url: "https://arca.live") do |element|
          case element.name
          in "a" if element["href"].present?
            element["href"] = element["href"].gsub(%r{\Ahttps?://unsafelink\.com/}i, "")
          in "video"
            # Placeholder text for unsupported browsers.
            element.content = nil
          else
            nil
          end
        end.squeeze("\n\n").strip
      end

      def post_id
        parsed_url.post_id || parsed_referer&.post_id
      end

      def api_url
        "https://arca.live/api/app/view/article/breaking/#{post_id}" if post_id.present?
      end

      def http
        super.headers("User-Agent": "net.umanle.arca.android.playstore/0.9.75")
      end

      def http_downloader
        super.disable_feature(:spoof_referrer)
      end

      memoize def api_response
        http.cache(1.minute).parsed_get(api_url) || {}
      end
    end
  end
end
