# frozen_string_literal: true

require "test_helper"

module Sources
  class PrivatterTest < ActiveSupport::TestCase
    context "Privatter:" do
      context "A Privatter post URL" do
        strategy_should_work(
          "https://privatter.net/i/7184521",
          image_urls: %w[
            https://d2pqhom6oey9wx.cloudfront.net/img_original/6501563076473624f29c22.png
            https://d2pqhom6oey9wx.cloudfront.net/img_original/1614590486473624eeee0d.jpg
            https://d2pqhom6oey9wx.cloudfront.net/img_original/12626922166473624f79ee5.png
          ],
          media_files: [
            { file_size: 648_090 },
            { file_size: 445_639 },
            { file_size: 577_777 },
          ],
          page_url: "https://privatter.net/i/7184521",
          profile_urls: ["https://privatter.net/u/GLK_Sier"],
          display_name: "GLKS🥐",
          username: "GLK_Sier",
          tags: [],
          dtext_artist_commentary_title: "【斥罪 Penance】Saturday Night",
          dtext_artist_commentary_desc: "",
        )
      end

      context "A direct image URL" do
        strategy_should_work(
          "https://d2pqhom6oey9wx.cloudfront.net/img_original/6501563076473624f29c22.png",
          image_urls: %w[
            https://d2pqhom6oey9wx.cloudfront.net/img_original/6501563076473624f29c22.png
          ],
          media_files: [
            { file_size: 648_090 },
          ],
        )
      end

      context "A preview image URL" do
        strategy_should_work(
          "https://d2pqhom6oey9wx.cloudfront.net/img_resize/6501563076473624f29c22.png",
          image_urls: %w[
            https://d2pqhom6oey9wx.cloudfront.net/img_original/6501563076473624f29c22.png
          ],
          media_files: [
            { file_size: 648_090 },
          ],
        )
      end

      context "A blog post URL" do
        strategy_should_work(
          "https://privatter.net/p/8037485",
          image_urls: %w[
            https://d2pqhom6oey9wx.cloudfront.net/img_original/6475430776165b1cce19f7.jpg
            https://d2pqhom6oey9wx.cloudfront.net/img_original/15707113576165b1ccea1d7.jpg
            https://d2pqhom6oey9wx.cloudfront.net/img_original/1886457056165b1ccf258f.jpg
            https://d2pqhom6oey9wx.cloudfront.net/img_original/19390624546165b1cd06b14.jpg
            https://d2pqhom6oey9wx.cloudfront.net/img_original/8525841906165b1cd0f140.jpg
            https://d2pqhom6oey9wx.cloudfront.net/img_original/3299633416165b0d438110.jpg
            https://d2pqhom6oey9wx.cloudfront.net/img_original/4373300416165b0d440cce.jpg
            https://d2pqhom6oey9wx.cloudfront.net/img_original/18548571176165b0d4492b4.jpg
            https://d2pqhom6oey9wx.cloudfront.net/img_original/14051032946165b0d451a9c.jpg
            https://d2pqhom6oey9wx.cloudfront.net/img_original/18069409056165b0d459dd5.jpg
          ],
          media_files: [
            { file_size: 176_094 },
            { file_size: 198_222 },
            { file_size: 254_037 },
            { file_size: 199_774 },
            { file_size: 240_532 },
            { file_size: 191_273 },
            { file_size: 249_460 },
            { file_size: 255_777 },
            { file_size: 207_261 },
            { file_size: 168_482 },
          ],
          page_url: "https://privatter.net/p/8037485",
          profile_urls: ["https://privatter.net/u/yakko_ss"],
          display_name: "ヤッコ",
          username: "yakko_ss",
          tags: [],
          dtext_artist_commentary_title: "#ウィザーズシンフォニー　初見プレイ記録⑤　クリア後　※ネタバレ有",
          dtext_artist_commentary_desc: <<~EOS.chomp,
            各アフターはさすがにパラレル？ なんだと思うけど…あ、あ、アステル～～；；
            アステルとのアフターだけは、アルトがあの後誰をパートナーに選んだとしてもこういう時間があったと信じたいなあ。

            可能ならアルトとフィーちゃんを筆頭に、かつての仲間たちみんなで色んな知識を持ち寄って、アステルの身体を長持ちさせてあげる話になって欲しい。
            この後さらにグランスカの遺跡や遺物が発見されるかもしれないしさ～～！
            兄上が何らかの情報残してるかもしれないしさ～～～ヴァシレウスがどっかからお土産持ってきてくれるかもしれないしさ～～～！
            きっと望みはあるよ。自分の中ではそういうEDだよ決定！！！！！！！異議なし！！！！

            全然関係ないけどアルトとアステルって髪型同じだし、顔立ちも似てるんだね。
            テナール自身を参考に創ったのかもしれないけど、兄妹みたいで可愛いな。

            ----------------------------------------

            紫翠くんとのアフター、アルトくんに念飛ばしすぎててちょっとびっくりしたｗ

            紫翠くんに対して「結婚の約束はおろか、ちゃんと恋人として付き合ってるかどうかも怪しい相手を故郷に置いて旅に出て、数年後に求婚するつもりで満を持して戻ってきたら相手はとっくに別の人と家庭を築いていた的な気の毒なDT」みたいなイメージを勝手に抱いてるんだけど、すごくそれっぽいなと思ってしまった。

            公式と解釈が一致なら嬉しいね……可愛いね……。

            ----------------------------------------

            男性陣とのストーリーは割と平和だったけど、エルリックと絡んでるときのアルトが一番可愛くて笑った。
            さすが初見壁ドンメガネ野郎は違うな。
            もし本当に探偵事務所やるならホームズとワトソンみたいになりそうで良い。

            "[image]":[https://d2pqhom6oey9wx.cloudfront.net/img_original/6475430776165b1cce19f7.jpg]
            "[image]":[https://d2pqhom6oey9wx.cloudfront.net/img_original/15707113576165b1ccea1d7.jpg]
            "[image]":[https://d2pqhom6oey9wx.cloudfront.net/img_original/1886457056165b1ccf258f.jpg]
            "[image]":[https://d2pqhom6oey9wx.cloudfront.net/img_original/19390624546165b1cd06b14.jpg]
            "[image]":[https://d2pqhom6oey9wx.cloudfront.net/img_original/8525841906165b1cd0f140.jpg]
            ----------------------------------------

            アフターストーリー観た。

            アエエエエエエエエエエ！！？！？？！？！？？？！？

            ア ル ト て め え

            "[image]":[https://d2pqhom6oey9wx.cloudfront.net/img_original/3299633416165b0d438110.jpg]
            "[image]":[https://d2pqhom6oey9wx.cloudfront.net/img_original/4373300416165b0d440cce.jpg]
            "[image]":[https://d2pqhom6oey9wx.cloudfront.net/img_original/18548571176165b0d4492b4.jpg]
            "[image]":[https://d2pqhom6oey9wx.cloudfront.net/img_original/14051032946165b0d451a9c.jpg]
            "[image]":[https://d2pqhom6oey9wx.cloudfront.net/img_original/18069409056165b0d459dd5.jpg]
          EOS
        )
      end

      context "A blog post with no commentary" do
        should "not include the images in the commentary" do
          strategy = Source::Extractor.find("https://privatter.net/p/4902858")
          assert_equal("主人公１～５やんわり設定", strategy.dtext_artist_commentary_title)
          assert_equal("", strategy.dtext_artist_commentary_desc)
        end
      end

      context "A password-protected URL" do
        strategy_should_work(
          "https://privatter.net/i/7308463",
          image_urls: [],
          page_url: "https://privatter.net/i/7308463",
          profile_urls: ["https://privatter.net/u/GLK_Sier"],
          display_name: "GLKS🥐",
          username: "GLK_Sier",
        )
      end

      context "A profile URL" do
        strategy = Source::Extractor.find("https://privatter.net/u/GLK_Sier")

        should "return the profile URL" do
          assert_equal(["https://privatter.net/u/GLK_Sier"], strategy.profile_urls)
        end
      end

      context "A dead link" do
        should "not raise anything" do
          assert_nothing_raised do
            Source::Extractor.find("https://privatter.net/i/29851").to_h
          end
        end
      end
    end
  end
end
