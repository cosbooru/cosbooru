# frozen_string_literal: true

class Source::URL::CosplayerArchive < Source::URL
  attr_reader :user_id, :image_id, :image_server

  def self.match?(url)
    url.domain == "cosp.jp"
  end

  def parse
    case [subdomain, domain, *path_segments]

    # https://image7.cosp.jp/images/member/g/516/516768/13075578_740.jpg
    # https://image7.cosp.jp/images/member/g/516/516768/13075578b.jpg
    # https://image7.cosp.jp/images/member/g/516/516768/13075578.jpg
    # https://image7.cosp.jp/thumb/member/g/516/516768/13075578m.jpg
    in /^image[0-9]$/ => image_server, _, ("images" | "thumb"), "member", "g", _, user_id, image
      @image_server = image_server
      @user_id = user_id.to_i
      @image_id = image.match(/^(\d+)(?:|_\d+|[a-z])\.(?:gif|jpg)$/)[1].to_i

    # https://cosp.jp/prof.aspx?id=516768
    in _, _, "prof.aspx" if params["id"].present?
      @user_id = params["id"].to_i

    # https://cosp.jp/view_photo.aspx?id=13075578&m=516768
    in _, _, "view_photo.aspx" if params["id"].present? && params["m"].present?
      @user_id = params["m"].to_i
      @image_id = params["id"].to_i

    # https://cosp.jp/photo_search.aspx?n1=516768
    in _, _, "photo_search.aspx" if params["n1"].present?
      @user_id = params["n1"].to_i
    else
      nil
    end
  end

  def image_url?
    subdomain.present? && subdomain.match(/^image[0-9]$/) && path.match(%r{^/(images|thumb)/member/g/\d{3}/\d+/\d+(?:|_\d+|[a-z])\.(?:gif|jpg)$})
  end

  def page_url
    return unless user_id.present? && image_id.present?
    "https://cosp.jp/view_photo.aspx?id=#{@image_id}&m=#{@user_id}"
  end

  def profile_url
    "https://cosp.jp/prof.aspx?id=#{@user_id}" if user_id.present?
  end

  def full_image_url
    # https://image7.cosp.jp/images/member/g/516/516768/13075578.jpg
    return unless image_server.present? && user_id.present? && image_id.present?
    "https://#{@image_server}.cosp.jp/images/member/g/#{@user_id.to_s[...-3].to_i}/#{@user_id}/#{@image_id}.jpg"
  end
end
