# frozen_string_literal: true

#
# | Parameter | Datatype | Meaning
# |-----------|----------|----------
# | l         | int      | Page limit or list size
# | p         | int      | Page number
# | s         | int      | Sort order (determines the sort criteria): 1: ascending 登録日 (registration date), 0: descending 登録日, 3: ascending 名前 (name), 2: descending 名前, 5: ascending 作品名 (work title), 4: descending 作品名, 7: ascending レベル (level), 6: descending レベル, 9: ascending 参照数 (reference count), 8: descending 参照数, 11: ascending スター数 (star count), 10: descending スター数
# | d         | int      | Description display mode (0: Short description, 1: Long description with date, 2: Thumbnail only)
# | c         | int      | Total count of images (returned by the API; may be omitted from the request)
# | b         | int      | Thumbnail size (0: small, 1: medium, 2: large)
# | kt        | int      | Keyword type: 0: 作品・キャラクター (Works & Characters), 1: 会場・イベント (Venues & Events), 2: コスプレイヤー (Cosplayers)
# | k         | string   | Search keyword
# | t         | string   | Default value or placeholder
# | nt        | string   | Navigation or notification flag
# | n1        | int      | User profile
# | n2        | int      | Work or content
# | n3        | int      | Character or work
# | n4        | int      | Location or event
# | n5        | int      | Photoshoot or occasion (returns event details, such as title, venue, date, and member participation)
# | n6        | int      | Variation
# | n7        | int      | Camera or model
# | n8        | int      | Lens
# | n9        | int      | Photographer or contributor
# | n10       | int      | Situation
# | o1        | bool     | Male cosplayer flag
# | o2        | bool     | Female cosplayer flag
# | o3        | bool     | Special cosplayers flag (popular/high level)
# | o4        | bool     | Naisu Shotto flag
# | o5        | string   | Unknown
# | o6        | int      | Content display filter (0: Both, 1: PC only, 2: Mobile only)

class Source::Extractor::CosplayerArchive < Source::Extractor
  delegate :profile_url, to: :parsed_url

  def image_urls
    [parsed_url.full_image_url] if parsed_url.full_image_url.present?

    return [] unless page.present?

    [Source::URL.parse(page.at("#imgView").attr(:src)).full_image_url]
  end

  def display_name
    user_link&.text
  end

  def username
    "cosp_#{parsed_url.user_id}" if parsed_url.user_id.present?
  end

  memoize def user_link
    page&.at("a[href^='/photo_search.aspx?n1=']")
  end

  memoize def page
    return nil if parsed_url.page_url.blank?
    res = http.cache(1.minute).get(parsed_url.page_url)

    # Manually parse it because this site yields Shift-JIS
    HTTP::MimeType[res.mime_type].decode(res.to_s.force_encoding("shift_jis").encode("UTF-8"))
  end

  def artist_commentary_desc
    page.at("span.black_mui14150")&.text
  end
end
