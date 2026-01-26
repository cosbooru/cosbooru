require "test_helper"

module Sources
  class CosplayerArchiveTest < ActiveSupport::TestCase
    context "A normal post" do
      strategy_should_work(
        "https://www.cosp.jp/view_photo.aspx?id=9839344&m=243519",
        image_urls: %w[https://image7.cosp.jp/images/member/g/243/243519/9839344.jpg],
        media_files: [{ file_size: 322_827 }],
        page_url: "https://cosp.jp/view_photo.aspx?id=9839344&m=243519",
        profile_urls: %w[https://cosp.jp/prof.aspx?id=243519],
        display_name: "ぷりん",
        username: "cosp_243519",
        tags: [
          [
            "ラブライブ! School idol project",
            "https://cosp.jp/photo_search.aspx?n2=10514"
          ],
          [
            "南ことり",
            "https://cosp.jp/photo_search.aspx?n3=59425"
          ],
          [
            "Snow halation",
            "https://cosp.jp/photo_search.aspx?n6=34577"
          ]
        ],
        dtext_artist_commentary_title: "",
        dtext_artist_commentary_desc: "冬といえばスノハレ〜(*´ω`*人)♪"
      )
    end

    context "A sample link" do
      strategy_should_work(
        "https://image7.cosp.jp/images/member/g/516/516768/13074548b.jpg",
        image_urls: %w[https://image7.cosp.jp/images/member/g/516/516768/13074548.jpg],
        media_files: [{ file_size: 1_141_365 }],
        page_url: "https://cosp.jp/view_photo.aspx?id=13074548&m=516768",
        profile_urls: %w[https://cosp.jp/prof.aspx?id=516768],
        display_name: "のはね",
        username: "cosp_516768",
        tags: [],
        dtext_artist_commentary_title: "",
        dtext_artist_commentary_desc: ""
      )
    end

    context "A direct image link" do
      strategy_should_work(
        "https://image7.cosp.jp/images/member/g/516/516768/13072817.jpg",
        image_urls: %w[https://image7.cosp.jp/images/member/g/516/516768/13072817.jpg],
        media_files: [{ file_size: 851_670 }],
        page_url: "https://cosp.jp/view_photo.aspx?id=13072817&m=516768",
        profile_urls: %w[https://cosp.jp/prof.aspx?id=516768],
        display_name: "のはね",
        username: "cosp_516768",
        tags: [],
        dtext_artist_commentary_title: "",
        dtext_artist_commentary_desc: ""
      )
    end

    should "Parse cosp.jp URLs correctly" do
      assert(Source::URL.image_url?("https://image7.cosp.jp/images/member/g/516/516768/13075578_740.jpg"))
      assert(Source::URL.image_url?("https://image7.cosp.jp/images/member/g/516/516768/13075578b.jpg"))
      assert(Source::URL.image_url?("https://image7.cosp.jp/images/member/g/516/516768/13075578.jpg"))
      assert(Source::URL.image_url?("https://image7.cosp.jp/thumb/member/g/516/516768/13075578m.jpg"))
      assert(Source::URL.image_url?("https://image7.cosp.jp/images/member/g/516/516768/13075578.jpg"))

      assert(Source::URL.profile_url?("https://cosp.jp/prof.aspx?id=516768"))

      assert("https://cosp.jp/prof.aspx?id=516768", Source::URL.profile_url("https://cosp.jp/prof.aspx?id=516768"))

      assert(Source::URL.page_url?("https://cosp.jp/view_photo.aspx?id=13075578&m=516768"))

      assert_equal("https://cosp.jp/prof.aspx?id=516768", Source::URL.profile_url("https://image7.cosp.jp/images/member/g/516/516768/13075578_740.jpg"))
      assert_equal("https://cosp.jp/prof.aspx?id=516768", Source::URL.profile_url("https://image7.cosp.jp/images/member/g/516/516768/13075578b.jpg"))
      assert_equal("https://cosp.jp/prof.aspx?id=516768", Source::URL.profile_url("https://image7.cosp.jp/images/member/g/516/516768/13075578.jpg"))
      assert_equal("https://cosp.jp/prof.aspx?id=516768", Source::URL.profile_url("https://image7.cosp.jp/thumb/member/g/516/516768/13075578m.jpg"))
      assert_equal("https://cosp.jp/prof.aspx?id=516768", Source::URL.profile_url("https://image7.cosp.jp/images/member/g/516/516768/13075578.jpg"))

      assert_equal("https://cosp.jp/view_photo.aspx?id=13075578&m=516768", Source::URL.page_url("https://image7.cosp.jp/images/member/g/516/516768/13075578_740.jpg"))
      assert_equal("https://cosp.jp/view_photo.aspx?id=13075578&m=516768", Source::URL.page_url("https://image7.cosp.jp/images/member/g/516/516768/13075578b.jpg"))
      assert_equal("https://cosp.jp/view_photo.aspx?id=13075578&m=516768", Source::URL.page_url("https://image7.cosp.jp/images/member/g/516/516768/13075578.jpg"))
      assert_equal("https://cosp.jp/view_photo.aspx?id=13075578&m=516768", Source::URL.page_url("https://image7.cosp.jp/thumb/member/g/516/516768/13075578m.jpg"))
      assert_equal("https://cosp.jp/view_photo.aspx?id=13075578&m=516768", Source::URL.page_url("https://image7.cosp.jp/images/member/g/516/516768/13075578.jpg"))
    end
  end
end
