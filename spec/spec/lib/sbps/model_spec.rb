# encoding: utf-8
require 'spec_helper'
require 'support/sbps_configure_context'

describe Sbps::Model::Base do
  describe "#tripple_des" do
    include_context "sbps_configure"
    let(:model) { Sbps::Model::Base.new }
    subject { model.tripple_des("abcdefgh") }

    it "文字列が返ること" do
      should be_an_instance_of String 
    end
  end

  describe "#padding" do
    let(:model) { Sbps::Model::Base.new  }
    subject { model.send(:padding, str) }

    context "8バイトの文字を渡した時" do
      let(:str) { "abcdefgh" }

      it "16バイトになること" do
        subject.length.should == 16 
      end

      it "最後の8バイトが空白文字であること" do
        subject[-8, 8].should == "        "
      end
    end

    context "10バイトの文字を渡した時" do
      let(:str) { "abcdefghij" }
      
      it "16バイトになること" do
        subject.length.should == 16 
      end

      it "最後の6バイトが空白文字であること" do
        subject[-6, 6].should == "      "
      end
    end
  end

  describe "#replace_ng_word" do
    let(:model) { Sbps::Model::Base.new  }

    it "ーが-に置き換わること" do
      model.send(:replace_ng_word, "ー").should == "-"
    end

    it "＼が\\に置き換わること" do
      model.send(:replace_ng_word, "＼").should == "\\"
    end

    it "〜が~に置き換わること" do
      model.send(:replace_ng_word, "〜").should == "~"
    end
    
    it "‖が||に置き換わること" do
      model.send(:replace_ng_word, "‖").should == "||" 
    end
    
    it "–が-に置き換わること" do
      model.send(:replace_ng_word, "–").should =="-"
    end

    it "¢がセントに置き換わること" do
      model.send(:replace_ng_word, "¢").should == "セント"
    end

    it "£がポンドに置き換わること" do
      model.send(:replace_ng_word, "£").should == "ポンド"
    end

    it "¬が-に置き換わること" do
      model.send(:replace_ng_word, "¬").should == "-"
    end
  end
end
