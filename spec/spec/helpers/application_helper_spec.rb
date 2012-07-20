# -*- coding: utf-8 -*-
require 'spec_helper'
describe ApplicationHelper do

  shared_examples_for "youtube部分が`[[youtube|video_id]]`にconvertされること" do
    it "変換完了" do 
      convert_youtube2tmp_str(target_str).should == expect_str
    end
  end 

  shared_examples_for "<code>[[youtube|video_id]]</code>部分がyoutubeプレイヤーにconvertされること" do
    it "変換完了" do 
      convert_tmp_str2youtube_player(target_str, width, height).should == expect_str 
    end
  end 

  describe "#markdown" do
    it "改行が <br> に変更されていること" do
      markdown("uhoho\nuhoho").should == "<p>uhoho<br>\nuhoho</p>\n"
    end
  end

  describe "#convert_youtube2tmp_str" do
    context "\"aaa http://www.youtube.com/watch?v=_83P8ll3BEY bbb\" が `[[youtube|video_id]]` に置換されること" do
      let(:target_str) { 'aaa http://www.youtube.com/watch?v=aCYBS-A3g3Y bbb' }
      let(:expect_str) { "aaa `[[youtube|aCYBS-A3g3Y]]`\n bbb" }
      it_behaves_like 'youtube部分が`[[youtube|video_id]]`にconvertされること'
    end

    context "\"aaa http://www.youtube.com/watch?v=_83P8ll3BEY&feature=g-trend bbb\"が \"aaa `[[youtube|video_id]]`\n bbb\" に置換されること" do
      let(:target_str) { 'aaa http://www.youtube.com/watch?v=aCYBS-A3g3Y&feature=g-trend bbb' }
      let(:expect_str) { "aaa `[[youtube|aCYBS-A3g3Y]]`\n bbb" }
      it_behaves_like 'youtube部分が`[[youtube|video_id]]`にconvertされること'
    end

    context "\"aaa http://www.youtube.com/watch?feature=g-trebd&v=_83P8ll3BEY bbb\" が aaa `[[youtube|video_id]]`\n bbb に置換されること" do
      let(:target_str) { 'aaa http://www.youtube.com/watch?feature=g-trend&v=aCYBS-A3g3Y bbb' }
      let(:expect_str) { "aaa `[[youtube|aCYBS-A3g3Y]]`\n bbb" }
      it_behaves_like 'youtube部分が`[[youtube|video_id]]`にconvertされること'
    end

    context "複数個のyoutubeのURLあれば、それぞれ `[[youtube|video_id]]` に置換されること" do
      youtube_url1 = "http://www.youtube.com/watch?v=aCYBS-A3g3Y&feature=g-logo&context=G244fb17FOAAAAAAAUAA" 
      youtube_url2 = "http://www.youtube.com/watch?v=ISUy9PhPEJs&feature=g-logo&context=G2bcba91FOAAAAAAAbAA" 
      let(:target_str) { youtube_url1 + " and " + youtube_url2  }
      let(:expect_str) { "`[[youtube|aCYBS-A3g3Y]]`\n and `[[youtube|ISUy9PhPEJs]]`\n" }
      it_behaves_like 'youtube部分が`[[youtube|video_id]]`にconvertされること'
    end

    context "ただのURLや文字列であれば、`[[youtube|video_id]]` に置換されないこと" do
      str = "hogehoge  youtube aa http://www.google.co.jp/#sclient=psy-ab&hl=ja&site=&source=hp&q=let+it+snow&pbx=1&oq=let+it+snow&aq=f&aqi=g-z2g2&aql=1&gs_sm=e&gs_upl=1344l3072l0l3431l11l6l0l4l4l0l148l636l3.3l10l0&bav=on.2,or.r_gc.r_pw.,cf.osb&fp=2910fe17b6d314dc&biw=1600&bih=872"
      let(:target_str) { str }
      let(:expect_str) { str }
      it_behaves_like 'youtube部分が`[[youtube|video_id]]`にconvertされること'
    end
  end

  describe "#convert_tmp_str2youtube_player" do
    context "<code>[[youtube|video_id]]</code> の文字列があれば、youtubeプレイヤーに置換されること" do
      width = 425 
      height = 356 
      let(:target_str) { "<code>[[youtube|aCYBS-A3g3Y]]</code>" }
      let(:width) { width }
      let(:height) { height }
      let(:expect_str) { render :partial => "tickets/youtube", :locals => {:video_id => "aCYBS-A3g3Y", :width => width, :height => height} }
      it_behaves_like '<code>[[youtube|video_id]]</code>部分がyoutubeプレイヤーにconvertされること'
    end

    context "複数個の youtube 置き換え文字があれば、それぞれ youtubeプレイヤーに置換されること" do
      width = 1
      height = 1
      let(:target_str) { "<code>[[youtube|aCYBS-A3g3Y]]</code> and <code>[[youtube|ISUy9PhPEJs]]</code>" }
      let(:width) { width }
      let(:height) { height }
      let(:expect_str) { ( render :partial => "tickets/youtube", :locals => {:video_id => "aCYBS-A3g3Y", :width => width, :height => height} ) + " and " + ( render :partial => "tickets/youtube", :locals => {:video_id => "ISUy9PhPEJs", :width => width, :height => height} ) }
      it_behaves_like '<code>[[youtube|video_id]]</code>部分がyoutubeプレイヤーにconvertされること'
    end

    context "<code>[[youtube|video_id]] </code> ではyoutubeプレイヤーに変換されないこと" do
      width = 100 
      height = 150
      str = "<code>[[youtube|aCYBS-A3g3Y]] </code>"
      let(:target_str) { str }
      let(:width) { width }
      let(:height) { height }
      let(:expect_str) { str }
      it_behaves_like '<code>[[youtube|video_id]]</code>部分がyoutubeプレイヤーにconvertされること'
    end

    context "jsonフォーマット要求で、入力にyoutube記法があれば" do
      params = {:format => "json"}
      width = 550 
      height = 360 
      target_str = "<code>[[youtube|aCYBS-A3g3Y]]</code>"
      let(:expect_str) { ( render :partial => "tickets/youtube", :locals => {:video_id => "aCYBS-A3g3Y", :width => width, :height => height} ) }
      subject {convert_tmp_str2youtube_player(target_str, width, height)}
      it "youtubeプレイヤーに置換されること" do
        should == expect_str
      end
    end
  end

  describe "#convert_youtube_and_markdown" do
    it "入力された文字列に youtube の URL やマークダウン記法があれば変換されること" do
      width = 550 
      height = 360 
      target_str = "aaa http://www.youtube.com/watch?v=kl_eSXadx_w&feature=g-all-u&context=G2e7c401FAAAAAAAAUAA! bbb _cc_"
      player_str = render :partial => "tickets/youtube", :locals => {:video_id => "kl_eSXadx_w", :width => width, :height => height}
      expect_str = "<p>aaa #{player_str}<br>\n bbb <em>cc</em></p>\n"
      convert_youtube_and_markdown(target_str).should == expect_str
    end
  end

  describe "#br" do
    it "改行コードが<br>タグに変換されること" do
      helper.br("hoge\n").should == "hoge<br />\n"
    end

    it "<div>タグがちゃんとエスケープされていること" do
      helper.br("<div class='red'>hoge</div>").should == "&lt;div class='red'&gt;hoge&lt;/div&gt;"
    end
  end

end
