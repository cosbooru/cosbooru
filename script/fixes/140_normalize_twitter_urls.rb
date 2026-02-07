#!/usr/bin/env ruby

require_relative "base"

class PatchedArtist < Artist
  def add_url_warnings
  end
end

with_confirmation do
  start = Time.now
  count = PatchedArtist.joins(:urls).where_regex("artist_urls.url", '^https://twitter\.com/').group("artists.id").count.length
  PatchedArtist.joins(:urls).where_regex("artist_urls.url", '^https://twitter\.com/').group("artists.id").find_each.with_index do |artist, i|
    urls = artist.url_string
    urls = urls.gsub(%r{^https://twitter\.com/intent/user\?user_id=(\d+)}, 'https://x.com/i/user/\1')
    urls = urls.gsub(%r{^-https://twitter\.com/intent/user\?user_id=(\d+)}, '-https://x.com/i/user/\1')
    urls = urls.gsub(%r{^https://twitter\.com}, "https://x.com")
    urls = urls.gsub(%r{^-https://twitter\.com}, "-https://x.com")
    artist.update!(url_string: urls)

    if i & 1023 == 0
      elapsed = Time.now - start
      time_per_entry = elapsed / i
      estimate = time_per_entry * (count - i)
      puts "#{i} / #{count}, took #{elapsed} (ETA: #{estimate})"
    end
  end
end
