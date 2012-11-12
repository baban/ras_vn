# encoding: utf-8

require 'spec_helper'

describe RecipeDraft do
  fixtures :recipes, :recipe_drafts

  describe ".post_filter" do
    context "normal form" do
=begin
      let(:prms) do
        {
          "id"=>"11",
          "recipe_genre_selecter"=>"1",
          "new_food_genre"=>"", 
          "step_number"=>"1",
          "recipe"=>{
            "title"=>"♥アスパラとじゃがいものチーズサラダ♥",
            "description"=>"コロコロのアスパラとじゃがいもがとっても食べ易く、見た目も可愛いサラダです♡",
            "recipe_food_id"=>"1",
            "amount"=>"1",
            "one_point"=>"③では塩を1つまみくらいいれました。アンチョビの塩分によって変わるので、調整をしてください。",
            "public"=>"true"
          }, 
          "foodstuffs"=>[{"name"=>"", "amount"=>"３本"}, {"name"=>"じゃがいも", "amount"=>"中２個(約250ｇ)"}, {"name"=>"プロセスチーズ", "amount"=>"２個(約30ｇ)"}, {"name"=>"ハム", "amount"=>"２枚"}, {"name"=>"マヨネーズ", "amount"=>"大さじ１～２"}, {"name"=>"酢", "amount"=>"大さじ１/２"}, {"name"=>"コショー", "amount"=>"少々"}],
          "recipe_steps"=>[{"movie_url"=>"", "content"=>""}, {"movie_url"=>"", "content"=>""}, {"movie_url"=>"", "content"=>""}, {"movie_url"=>"", "content"=>""}],  
        }
=end
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

  describe "#edit_steps"
  describe "#edit_foodstuffs"
  describe "#copy_public" do
    before do
      @recipe = Recipe.first
      @draft  = @recipe.draft
      @draft.title="hogehoge"
      @draft.save
      @draft.copy_public
      @recipe.reload
    end
    it "タイトルをコピーする" do
      @draft.title.should == @recipe.title
    end
    it "要約をコピーする" do
      @draft.description.should == @recipe.description
    end
    it "要約をコピーする" do
      @draft.one_point.should == @recipe.one_point
    end
  end
end

