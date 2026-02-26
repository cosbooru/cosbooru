require "test_helper"

module Source::Tests::Extractor
  class CarrdExtractorTest < ActiveSupport::ExtractorTestCase
    context "An image URL that doesn't have an _original version" do
      strategy_should_work(
        "https://rosymiz.carrd.co/assets/images/gallery01/1a19b400.jpg?v=c6f079b5",
        image_urls: %w[https://rosymiz.carrd.co/assets/images/gallery01/1a19b400.jpg],
        media_files: [{ file_size: 75_371 }],
        page_url: nil,
        profile_urls: %w[https://rosymiz.carrd.co],
      )
    end

    context "A sample image URL that has an _original version" do
      strategy_should_work(
        "https://caminukai-art.carrd.co/assets/images/gallery27/042ca1a3.jpg?v=b2230a53",
        image_urls: %w[https://caminukai-art.carrd.co/assets/images/gallery27/042ca1a3_original.jpg],
        media_files: [{ file_size: 1_025_083 }],
        page_url: nil,
        profile_urls: %w[https://caminukai-art.carrd.co],
        display_name: nil,
        username: "caminukai-art",
        tags: [],
        dtext_artist_commentary_title: "",
        dtext_artist_commentary_desc: "",
      )
    end

    context "An _original full image URL" do
      strategy_should_work(
        "https://caminukai-art.carrd.co/assets/images/gallery27/042ca1a3_original.jpg",
        image_urls: %w[https://caminukai-art.carrd.co/assets/images/gallery27/042ca1a3_original.jpg],
        media_files: [{ file_size: 1_025_083 }],
        page_url: nil,
        profile_urls: %w[https://caminukai-art.carrd.co],
        display_name: nil,
        username: "caminukai-art",
        tags: [],
        dtext_artist_commentary_title: "",
        dtext_artist_commentary_desc: "",
      )
    end

    context "A video cover image" do
      strategy_should_work(
        "https://rosymiz.carrd.co/assets/videos/video02.mp4.jpg?v=c6f079b5",
        image_urls: %w[https://rosymiz.carrd.co/assets/videos/video02.mp4.jpg],
        media_files: [{ file_size: 454_589 }],
        page_url: nil,
        profile_urls: %w[https://rosymiz.carrd.co],
      )
    end

    context "A page with a single image" do
      strategy_should_work(
        "https://amyahue.carrd.co/#about",
        image_urls: %w[https://amyahue.carrd.co/assets/images/gallery01/4a05ad8e.png],
        media_files: [{ file_size: 153_385 }],
        page_url: "https://amyahue.carrd.co/#about",
        profile_urls: %w[https://amyahue.carrd.co],
        display_name: nil,
        username: "amyahue",
        published_at: nil,
        updated_at: nil,
        tags: [],
        dtext_artist_commentary_title: "",
        dtext_artist_commentary_desc: <<~EOS.chomp,
          hello !! i'm [b]aya[/b] ⭐

          * "Untitled":[https://amyahue.carrd.co/assets/images/gallery01/4a05ad8e.png]

          i'm a 20 year old artist based in california! i've been doing digital art for about 10 years, and am just getting started with selling my work!
        EOS
      )
    end

    context "A page with multiple images that don't have separate pages" do
      strategy_should_work(
        "https://lytell.carrd.co/#portfolio",
        image_urls: %w[
          https://lytell.carrd.co/assets/images/gallery04/bca0b2f2_original.jpg
          https://lytell.carrd.co/assets/images/gallery04/47493cd2_original.jpg
          https://lytell.carrd.co/assets/images/gallery04/3ac05b2e_original.jpg
          https://lytell.carrd.co/assets/images/gallery05/0b8d3183_original.jpg
          https://lytell.carrd.co/assets/images/gallery05/a9a31be0_original.jpg
          https://lytell.carrd.co/assets/images/gallery05/75d61bc7_original.jpg
        ],
        media_files: [
          { file_size: 223_413 },
          { file_size: 213_399 },
          { file_size: 104_650 },
          { file_size: 194_895 },
          { file_size: 271_921 },
          { file_size: 59_213 },
        ],
        page_url: "https://lytell.carrd.co/#portfolio",
        profile_urls: %w[https://lytell.carrd.co],
        display_name: nil,
        username: "lytell",
        tags: [],
        dtext_artist_commentary_title: "",
        dtext_artist_commentary_desc: <<~EOS.chomp,
          h1. portfolio

          illustrations - chibis - sketches
          [i]for designs, 2d animation, motion graphic animation please refer to my commission pages for those respective categories for samples[/i]

          * "[image]":[https://lytell.carrd.co/assets/images/gallery04/bca0b2f2_original.jpg]
          * "[image]":[https://lytell.carrd.co/assets/images/gallery04/47493cd2_original.jpg]
          * "[image]":[https://lytell.carrd.co/assets/images/gallery04/3ac05b2e_original.jpg]

          * "[image]":[https://lytell.carrd.co/assets/images/gallery05/0b8d3183_original.jpg]
          * "[image]":[https://lytell.carrd.co/assets/images/gallery05/a9a31be0_original.jpg]
          * "[image]":[https://lytell.carrd.co/assets/images/gallery05/75d61bc7_original.jpg]

          click for full playlist!
        EOS
      )
    end

    context "A page with multiple images that don't have _original versions" do
      strategy_should_work(
        "https://badkrol.carrd.co/#commission",
        image_urls: %w[
          https://badkrol.carrd.co/assets/images/gallery01/f0b76d31.jpg
          https://badkrol.carrd.co/assets/images/gallery01/2be61c25.jpg
          https://badkrol.carrd.co/assets/images/gallery01/06811411.jpg
          https://badkrol.carrd.co/assets/images/gallery01/34abf9bf.jpg
          https://badkrol.carrd.co/assets/images/gallery01/bd175d96.jpg
          https://badkrol.carrd.co/assets/images/gallery01/b7d14035.jpg
          https://badkrol.carrd.co/assets/images/gallery01/1092c7c0.jpg
          https://badkrol.carrd.co/assets/images/gallery01/d822c659.jpg
          https://badkrol.carrd.co/assets/images/gallery01/734f23b0.jpg
          https://badkrol.carrd.co/assets/images/gallery01/24fa71b4.jpg
          https://badkrol.carrd.co/assets/images/gallery01/bba5479e.jpg
          https://badkrol.carrd.co/assets/images/gallery01/b13b55a8.jpg
          https://badkrol.carrd.co/assets/images/gallery01/06ab2b47.jpg
          https://badkrol.carrd.co/assets/images/gallery01/1f27675c.jpg
          https://badkrol.carrd.co/assets/images/gallery01/6c23bf4e.jpg
          https://badkrol.carrd.co/assets/images/gallery01/91533ed2.jpg
          https://badkrol.carrd.co/assets/images/gallery01/914faf8b.jpg
          https://badkrol.carrd.co/assets/images/gallery01/64209a6e.jpg
          https://badkrol.carrd.co/assets/images/gallery01/b602a964.jpg
          https://badkrol.carrd.co/assets/images/gallery01/588d532b.jpg
          https://badkrol.carrd.co/assets/images/gallery01/670bc67a.jpg
          https://badkrol.carrd.co/assets/images/gallery01/5b7b4e30.jpg
          https://badkrol.carrd.co/assets/images/gallery01/2cc4abae.jpg
          https://badkrol.carrd.co/assets/images/gallery01/7eec4fec.jpg
          https://badkrol.carrd.co/assets/images/gallery01/a3afcff9.jpg
          https://badkrol.carrd.co/assets/images/gallery02/e9db9481.jpg
          https://badkrol.carrd.co/assets/images/gallery02/bcf1903f.jpg
          https://badkrol.carrd.co/assets/images/gallery02/3ac7eb98.jpg
          https://badkrol.carrd.co/assets/images/gallery02/84339c57.jpg
          https://badkrol.carrd.co/assets/images/gallery02/0214174e.jpg
          https://badkrol.carrd.co/assets/images/gallery02/0db4767e.jpg
          https://badkrol.carrd.co/assets/images/gallery02/8b01a93d.jpg
          https://badkrol.carrd.co/assets/images/gallery02/4451caa0.jpg
          https://badkrol.carrd.co/assets/images/gallery02/2ee5d457.jpg
          https://badkrol.carrd.co/assets/images/gallery02/5599d4f0.jpg
          https://badkrol.carrd.co/assets/images/gallery02/79557ece.jpg
          https://badkrol.carrd.co/assets/images/gallery02/5318021e.jpg
          https://badkrol.carrd.co/assets/images/gallery02/ef61cded.jpg
          https://badkrol.carrd.co/assets/images/gallery02/943552a2.jpg
          https://badkrol.carrd.co/assets/images/gallery02/8f23d83e.jpg
          https://badkrol.carrd.co/assets/images/gallery03/21cc702c.jpg
        ],
        media_files: [
          { file_size: 38_775 },
          { file_size: 7_395 },
          { file_size: 5_239 },
          { file_size: 12_937 },
          { file_size: 18_103 },
          { file_size: 10_727 },
          { file_size: 9_316 },
          { file_size: 12_553 },
          { file_size: 9_228 },
          { file_size: 11_381 },
          { file_size: 8_065 },
          { file_size: 20_635 },
          { file_size: 11_353 },
          { file_size: 10_785 },
          { file_size: 12_118 },
          { file_size: 8_038 },
          { file_size: 8_608 },
          { file_size: 9_687 },
          { file_size: 10_984 },
          { file_size: 12_161 },
          { file_size: 24_784 },
          { file_size: 7_830 },
          { file_size: 8_258 },
          { file_size: 9_633 },
          { file_size: 10_947 },
          { file_size: 9_222 },
          { file_size: 11_741 },
          { file_size: 8_746 },
          { file_size: 18_136 },
          { file_size: 17_550 },
          { file_size: 11_945 },
          { file_size: 22_405 },
          { file_size: 7_488 },
          { file_size: 16_564 },
          { file_size: 18_659 },
          { file_size: 11_345 },
          { file_size: 10_792 },
          { file_size: 11_225 },
          { file_size: 12_064 },
          { file_size: 10_123 },
          { file_size: 38_789 },
        ],
        page_url: "https://badkrol.carrd.co/#commission",
        profile_urls: %w[https://badkrol.carrd.co],
        display_name: nil,
        username: "badkrol",
        published_at: nil,
        updated_at: nil,
        tags: [],
        dtext_artist_commentary_title: "",
        dtext_artist_commentary_desc: <<~EOS.chomp,
          h1. Commission

          Commissions are currently [b]open[/b]
          Please read T.O.S and Contact

          [hr]

          Anime Style ( *some examples have incomplete rendering)

          * "Untitled":[https://badkrol.carrd.co/assets/images/gallery01/f0b76d31.jpg]
          * "Untitled":[https://badkrol.carrd.co/assets/images/gallery01/2be61c25.jpg]
          * "Untitled":[https://badkrol.carrd.co/assets/images/gallery01/06811411.jpg]
          * "Untitled":[https://badkrol.carrd.co/assets/images/gallery01/34abf9bf.jpg]
          * "Untitled":[https://badkrol.carrd.co/assets/images/gallery01/bd175d96.jpg]
          * "Untitled":[https://badkrol.carrd.co/assets/images/gallery01/b7d14035.jpg]
          * "Untitled":[https://badkrol.carrd.co/assets/images/gallery01/1092c7c0.jpg]
          * "Untitled":[https://badkrol.carrd.co/assets/images/gallery01/d822c659.jpg]
          * "Untitled":[https://badkrol.carrd.co/assets/images/gallery01/734f23b0.jpg]
          * "Untitled":[https://badkrol.carrd.co/assets/images/gallery01/24fa71b4.jpg]
          * "Untitled":[https://badkrol.carrd.co/assets/images/gallery01/bba5479e.jpg]
          * "Untitled":[https://badkrol.carrd.co/assets/images/gallery01/b13b55a8.jpg]
          * "Untitled":[https://badkrol.carrd.co/assets/images/gallery01/06ab2b47.jpg]
          * "Untitled":[https://badkrol.carrd.co/assets/images/gallery01/1f27675c.jpg]
          * "Untitled":[https://badkrol.carrd.co/assets/images/gallery01/6c23bf4e.jpg]
          * "Untitled":[https://badkrol.carrd.co/assets/images/gallery01/91533ed2.jpg]
          * "Untitled":[https://badkrol.carrd.co/assets/images/gallery01/914faf8b.jpg]
          * "Untitled":[https://badkrol.carrd.co/assets/images/gallery01/64209a6e.jpg]
          * "Untitled":[https://badkrol.carrd.co/assets/images/gallery01/b602a964.jpg]
          * "Untitled":[https://badkrol.carrd.co/assets/images/gallery01/588d532b.jpg]
          * "Untitled":[https://badkrol.carrd.co/assets/images/gallery01/670bc67a.jpg]
          * "Untitled":[https://badkrol.carrd.co/assets/images/gallery01/5b7b4e30.jpg]
          * "Untitled":[https://badkrol.carrd.co/assets/images/gallery01/2cc4abae.jpg]
          * "Untitled":[https://badkrol.carrd.co/assets/images/gallery01/7eec4fec.jpg]
          * "Untitled":[https://badkrol.carrd.co/assets/images/gallery01/a3afcff9.jpg]

          🎈Note:for additional difficulty of a character or artwork as a whole, additional fees may be added.🎈

          Illustration

          * "Untitled":[https://badkrol.carrd.co/assets/images/gallery02/e9db9481.jpg]
          * "Untitled":[https://badkrol.carrd.co/assets/images/gallery02/bcf1903f.jpg]
          * "Untitled":[https://badkrol.carrd.co/assets/images/gallery02/3ac7eb98.jpg]
          * "Untitled":[https://badkrol.carrd.co/assets/images/gallery02/84339c57.jpg]
          * "Untitled":[https://badkrol.carrd.co/assets/images/gallery02/0214174e.jpg]
          * "Untitled":[https://badkrol.carrd.co/assets/images/gallery02/0db4767e.jpg]
          * "Untitled":[https://badkrol.carrd.co/assets/images/gallery02/8b01a93d.jpg]
          * "Untitled":[https://badkrol.carrd.co/assets/images/gallery02/4451caa0.jpg]
          * "Untitled":[https://badkrol.carrd.co/assets/images/gallery02/2ee5d457.jpg]
          * "Untitled":[https://badkrol.carrd.co/assets/images/gallery02/5599d4f0.jpg]
          * "Untitled":[https://badkrol.carrd.co/assets/images/gallery02/79557ece.jpg]
          * "Untitled":[https://badkrol.carrd.co/assets/images/gallery02/5318021e.jpg]
          * "Untitled":[https://badkrol.carrd.co/assets/images/gallery02/ef61cded.jpg]
          * "Untitled":[https://badkrol.carrd.co/assets/images/gallery02/943552a2.jpg]
          * "Untitled":[https://badkrol.carrd.co/assets/images/gallery02/8f23d83e.jpg]

          Character Sheet ( Anime and Semi-r)

          * "Untitled":[https://badkrol.carrd.co/assets/images/gallery03/21cc702c.jpg]

          Backgrounds
        EOS
      )
    end

    context "A page with images and videos" do
      strategy_should_work(
        "https://rosymiz.carrd.co/#home",
        image_urls: %w[
          https://rosymiz.carrd.co/assets/images/image01.jpg
          https://rosymiz.carrd.co/assets/images/gallery01/1a46013e.jpg
          https://rosymiz.carrd.co/assets/images/gallery01/1a19b400.jpg
          https://rosymiz.carrd.co/assets/images/gallery01/f335f692.jpg
          https://rosymiz.carrd.co/assets/videos/video02.mp4
          https://rosymiz.carrd.co/assets/videos/video03.mp4
        ],
        media_files: [
          { file_size: 18_960 },
          { file_size: 149_988 },
          { file_size: 75_371 },
          { file_size: 54_056 },
          { file_size: 28_206_225 },
          { file_size: 6_043_606 },
        ],
        page_url: "https://rosymiz.carrd.co/#home",
        profile_url: "https://rosymiz.carrd.co",
        profile_urls: %w[https://rosymiz.carrd.co],
        display_name: nil,
        username: "rosymiz",
        published_at: nil,
        updated_at: nil,
        tags: [],
        dtext_artist_commentary_title: "",
        dtext_artist_commentary_desc: <<~EOS.chomp,
          "[image]":[https://rosymiz.carrd.co/assets/images/image01.jpg]

          h1. [b]Alice Choi[/b]

          h3. [b]3D Character Art & Animation  -  Motion Designer[/b]

          [hr]

          Hello! I am a 3D Character Artist, who specializes in 3D modeling and animation for stylized games! I also freelance in motion design, specifically animated illustrations!

          [hr]

          h3. 3D Animation Demo Reel

          h3. 3D Character Art

          * "[image]":[https://rosymiz.carrd.co/assets/images/gallery01/1a46013e.jpg]
          * "[image]":[https://rosymiz.carrd.co/assets/images/gallery01/1a19b400.jpg]
          * "[image]":[https://rosymiz.carrd.co/assets/images/gallery01/f335f692.jpg]

          h3. Motion Design

          "[video]":[https://rosymiz.carrd.co/assets/videos/video02.mp4]

          @HoYoTabletop
          Artist: @ddengart

          "[video]":[https://rosymiz.carrd.co/assets/videos/video03.mp4]

          @HoYoTabletop
          Artist: @sorryoutofrice
        EOS
      )
    end

    context "A page with data:image/* URLs in the img[data-src] attributes" do
      strategy_should_work(
        "https://silvivtuber.carrd.co/#ref",
        image_urls: %w[
          https://silvivtuber.carrd.co/assets/images/image16.jpg
          https://silvivtuber.carrd.co/assets/images/image14.png
        ],
        media_files: [
          { file_size: 470_226 },
          { file_size: 3_362_739 },
        ],
        page_url: "https://silvivtuber.carrd.co/#ref",
        profile_urls: %w[https://silvivtuber.carrd.co],
        display_name: nil,
        username: "silvivtuber",
        tags: [],
        dtext_artist_commentary_title: "",
        dtext_artist_commentary_desc: <<~EOS.chomp,
          "[image]":[https://silvivtuber.carrd.co/assets/images/image16.jpg]

          "[image]":[https://silvivtuber.carrd.co/assets/images/image14.png]

          h2. ・ANGEL SILVI ・ REFERENCE

          [b]Species:[/b] Owl
          [b]Gender:[/b] Female
          [b]Height:[/b] 5 Feet and a half inch tall (154 cm)
          [b]Birthday:[/b] March 3rd
          [b]Body Type:[/b] Slender
          [b]Eye Color:[/b] Light Blue
          [b]Hair Color:[/b] Blonde, almost creamy white

          [b][ Notes][/b]
          ✧ Flat chested
          ✧ Big Hairbuns
          ✧ Elf ears
          ✧ Halo and Wings with Armorplates[b][Personality][/b]
          Like a Cute Angel, she will sing you a song!
        EOS
      )
    end

    context "A crd.co page" do
      strategy_should_work(
        "https://soycatate.crd.co/#portfolio",
        image_urls: %w[
          https://soycatate.crd.co/assets/images/gallery02/8b38245f_original.jpg
          https://soycatate.crd.co/assets/images/gallery02/7927e76f_original.jpg
          https://soycatate.crd.co/assets/images/gallery02/870dbb00_original.jpg
          https://soycatate.crd.co/assets/images/gallery03/c4f9ba75_original.jpg
          https://soycatate.crd.co/assets/images/gallery03/5035b188_original.jpg
          https://soycatate.crd.co/assets/images/gallery03/372cdeb2_original.jpg
          https://soycatate.crd.co/assets/images/gallery01/c0d06614_original.jpg
          https://soycatate.crd.co/assets/images/gallery01/029db4d2_original.jpg
          https://soycatate.crd.co/assets/images/gallery01/5a949634_original.jpg
          https://soycatate.crd.co/assets/images/image04.png
        ],
        media_files: [
          { file_size: 227_835 },
          { file_size: 182_706 },
          { file_size: 196_199 },
          { file_size: 425_891 },
          { file_size: 210_504 },
          { file_size: 202_039 },
          { file_size: 316_880 },
          { file_size: 318_048 },
          { file_size: 189_924 },
          { file_size: 17_248 },
        ],
        page_url: "https://soycatate.crd.co/#portfolio",
        profile_urls: %w[https://soycatate.crd.co],
        display_name: nil,
        username: "soycatate",
        tags: [],
        dtext_artist_commentary_title: "",
        dtext_artist_commentary_desc: <<~EOS.chomp,
          h1. Portfolio

          * "[image]":[https://soycatate.crd.co/assets/images/gallery02/8b38245f_original.jpg]
          * "[image]":[https://soycatate.crd.co/assets/images/gallery02/7927e76f_original.jpg]
          * "[image]":[https://soycatate.crd.co/assets/images/gallery02/870dbb00_original.jpg]

          * "[image]":[https://soycatate.crd.co/assets/images/gallery03/c4f9ba75_original.jpg]
          * "[image]":[https://soycatate.crd.co/assets/images/gallery03/5035b188_original.jpg]
          * "[image]":[https://soycatate.crd.co/assets/images/gallery03/372cdeb2_original.jpg]

          * "[image]":[https://soycatate.crd.co/assets/images/gallery01/c0d06614_original.jpg]
          * "[image]":[https://soycatate.crd.co/assets/images/gallery01/029db4d2_original.jpg]
          * "[image]":[https://soycatate.crd.co/assets/images/gallery01/5a949634_original.jpg]

          "[image]":[https://soycatate.crd.co/assets/images/image04.png]
        EOS
      )
    end

    context "For a custom domain:" do
      context "A page URL" do
        strategy_should_work(
          "https://hyphensam.com/#test-image",
          image_urls: %w[https://hyphensam.com/assets/images/image04.jpg],
          media_files: [{ file_size: 14_413 }],
          page_url: "https://hyphensam.com/#test-image",
          profile_url: "https://hyphensam.com",
          profile_urls: %w[https://hyphensam.com],
          username: nil,
          other_names: [],
          tags: [],
          dtext_artist_commentary_title: "",
          dtext_artist_commentary_desc: <<~EOS.chomp,
            "[image]":[https://hyphensam.com/assets/images/image04.jpg]

            Test text blah blah blah
          EOS
        )
      end

      context "An image URL with a referer" do
        strategy_should_work(
          "https://hyphensam.com/assets/images/image04.jpg?v=2cc95429",
          referer: "https://hyphensam.com/#test-image",
          image_urls: %w[https://hyphensam.com/assets/images/image04.jpg],
          media_files: [{ file_size: 14_413 }],
          page_url: "https://hyphensam.com/#test-image",
          profile_url: "https://hyphensam.com",
          profile_urls: %w[https://hyphensam.com],
          username: nil,
          other_names: [],
          tags: [],
          dtext_artist_commentary_title: "",
          dtext_artist_commentary_desc: <<~EOS.chomp,
            "[image]":[https://hyphensam.com/assets/images/image04.jpg]

            Test text blah blah blah
          EOS
        )
      end

      context "An image URL without a referer" do
        strategy_should_work(
          "https://hyphensam.com/assets/images/image04.jpg?v=2cc95429",
          image_urls: %w[https://hyphensam.com/assets/images/image04.jpg?v=2cc95429],
          media_files: [{ file_size: 14_413 }],
          page_url: nil,
          profile_url: nil,
        )
      end
    end
  end
end
