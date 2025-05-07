# frozen_string_literal: true

# API client for the internal yt-dlp client
# 
# @see https://github.com/cosbooru/yt-client

class YtClient
  attr_reader :yt_client_url, :http

  # Create a new YT API client.
  # @param yt_client_url [String] the base URL of the client service
  # @param http [Danbooru::Http] the HTTP client to use
  def initialize(yt_client_url: Danbooru.config.yt_client_url.to_s, http: Danbooru::Http.internal)
    @yt_client_url = yt_client_url.chomp("/")
    @http = http
  end

  def enabled?
    @yt_client_url.present?
  end

  # Request a video's data
  # @param service [String] Specific service to query
  # @param video_id [String] YouTube video ID
  def info(service, video_id)
    return if !enabled?

    response = http.timeout(30).send(:get, "#{yt_client_url}/#{service}/info/#{video_id}")
    raise Error, "yt-client error: #{service}/#{video_id} - #{response.status}" if response.status != 200
    response.parse
  end
end
