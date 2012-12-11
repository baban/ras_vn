# encoding: utf-8

require 'spec_helper'

describe RecipeFoodstuffDraft do
  describe ".post_filter" do
    context "normal form" do
      let(:prms) do
        {
          foodstuffs: [
            { name: "", amount: "３本"},
            { name:"じゃがいも", amount: "中２個(約250ｇ)"},
            { name: "プロセスチーズ", amount: "２個(約30ｇ)"},
            { name: "ハム", amount: "２枚"},
            { name: "マヨネーズ", amoun: "大さじ１～２"},
            { name: "酢", amount: "大さじ１/２"},
            { name: "コショー", amount: "少々"}
          ]
        }
      end
      before do
        @foodstuffs = RecipeFoodstuffDraft.post_filter( prms[:foodstuffs] )
      end
      it "両方値のあるデータだけで数値を出す" do
        @foodstuffs.size.should == 5
      end
    end
    context "blank values" do
      before do
        @foodstuffs = RecipeFoodstuffDraft.post_filter( {} )
      end
      it "両方値のあるデータだけで数値を出す" do
        @foodstuffs.size.should == 0
      end
      it "両方値のあるデータだけで数値を出す" do
        @foodstuffs.should == []
      end
    end
    context "nil values" do
      before do
        @foodstuffs = RecipeFoodstuffDraft.post_filter( nil )
      end
      it "両方値のあるデータだけで数値を出す" do
        @foodstuffs.size.should == 0
      end
      it "両方値のあるデータだけで数値を出す" do
        @foodstuffs.should == []
      end
    end
    context "blanks values" do
      let(:prms) do
        {
          foodstuffs: [
            { name: "", amount: "" },
            { name: "", amount: 0 },
            { name: "", amount: 1 },
            { name: "aaa", amount: "" },
            { name: "", amoun: "" },
            { name: "", amount: "" },
            { name: "", amount: "" },
          ]
        }
      end

      before do
        @foodstuffs = RecipeFoodstuffDraft.post_filter( prms[:foodstuffs] )
      end

      it "両方値のあるデータだけで数値を出す" do
        @foodstuffs.size.should == 0
      end

      it "両方値のあるデータだけで数値を出す" do
        @foodstuffs.should == []
      end
    end
    context "blank amount"
    context "blank name"
  end
end

