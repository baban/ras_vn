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
  end
  describe "#calc_calory" do
    context "個数" do
      before do
        @foodstuff = RecipeFoodstuffDraft.new( recipe_draft_id: 1, recipe_food_id: 0, name: "じゃがいも", amount: "1個" )
        @foodstuff.calc_calory
      end
      it "カロリーを計算して入力する" do
        @foodstuff.calory.should == 160
      end
    end
    context "g表示" do
      before do
        @foodstuff = RecipeFoodstuffDraft.new( recipe_draft_id: 1, recipe_food_id: 0, name: "山芋", amount: "200g" )
        @foodstuff.calc_calory
      end
      it "カロリーを計算して入力する" do
        @foodstuff.calory.should == 65*2
      end
    end
    context "変換不能" do
      before do
        @foodstuff = RecipeFoodstuffDraft.new( recipe_draft_id: 1, recipe_food_id: 0, name: "ほげほげ", amount: "200g" )
        @foodstuff.calc_calory
      end
      it "カロリーを計算して入力する" do
        @foodstuff.calory.should be_nil
      end
    end
  end
end

