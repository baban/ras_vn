# encoding: utf-8

require 'spec_helper'

describe Recipe do
  fixtures :recipes, :recipe_food_genres, :recipe_foods

  describe "#view_count_increment!" do
    context "normal test" do
      before do
        @recipe = Recipe.first
        @before_view_count = @recipe.view_count
        @recipe.view_count_increment!
      end
      it "カウントを１上げる" do
        @recipe.view_count.should == @before_view_count+1
      end
    end
  end

  describe ".love" do
    context "normal test" do
      before do
        @recipe = Recipe.find(1)
        @before_count = @recipe.love_count
        Recipe.love( id: 1, user_id: 1 )
      end
      it "カウントを１上げる" do
        @recipe = Recipe.find(1)
        @recipe.love_count == @before_count+1
      end
    end
  end

  describe ".post" do
    fixtures :users, :user_profiles, :user_profile_visibilities, :recipe_drafts, :recipe_foodstuff_drafts, :recipe_step_drafts

    let(:prms) do
      h = {
        "id"=>"11",
        "step_number_1"=>"1",
        "step_number_2"=>"2",
        "step_number_3"=>"3",
        "step_number_4"=>"4", 
        "step_number"=>"1", "vq"=>"", 
        "edit"=>"Lưu tạm thời", 
        "recipe_genre_selecter"=>"2",
        "hidden_recipe_food_id"=>"13",
        "new_food_genre"=>"",
        "recipe"=>{
          "title"=>"♥アスパラとじゃがいものチーズサラダ♥",
          "recipe_image_cache"=>"",
          "description"=>"コロコロのアスパラとじゃがいもがとっても食べ易く、見た目も可愛いサラダです♡",
          "recipe_food_id"=>"13",
          "amount"=>"1",
          "one_point"=>"③では塩を1つまみくらいいれました。アンチョビの塩分によって変わるので、調整をしてください。 "
        },
        "foodstuffs"=>[
           {"name"=>"アスパラ", "amount"=>"３本"},
           {"name"=>"じゃがいも", "amount"=>"中２個(約250ｇ)"},
           {"name"=>"プロセスチーズ", "amount"=>"２個(約30ｇ)"},
           {"name"=>"ハム", "amount"=>"２枚"},
           {"name"=>"マヨネーズ", "amount"=>"大さじ１～２"},
           {"name"=>"酢", "amount"=>"大さじ１/２"},
           {"name"=>"コショー", "amount"=>"少々"}
        ], 
        "recipe_steps"=>[
          {"content"=>"aaaa", "movie_url"=>"http://www.youtube.com/v/h8BNqDkf77w?version=3&f=videos&app=youtube_gdata"},
          {"content"=>"", "movie_url"=>"http://www.youtube.com/v/B3T_Kf1LPeA?version=3&f=videos&app=youtube_gdata"}, 
          {"content"=>"", "movie_url"=>"http://www.youtube.com/v/XlrLp4EpVLU?version=3&f=videos&app=youtube_gdata"},
          {"content"=>"", "movie_url"=>""}
        ], 
      }
      ActiveSupport::HashWithIndifferentAccess.new(h)
    end
    context "normal test" do
      before do
        params = prms
        @user = User.first
        @draft = RecipeDraft.find( params[:id] )
        @draft.post( params, @user )
        @draft.recipe_image = File.open( File.join(Rails.root.to_path,"public/favicon.gif") )
      end
      it "validation is true" do
        @draft.valid?.should be_true
      end
    end

    context "step text is too long" do
      before do
        params = prms
        @user = User.first
        @draft = RecipeDraft.find( params[:id] )
        @draft.post( params, @user )
        @draft.recipe_image = File.open( File.join(Rails.root.to_path,"public/favicon.gif") )
      end
      it "validation is true" do
        @draft.valid?.should be_true
      end
    end
  end

  describe ".list" do
    context "blank parameter" do
      before do
        @recipes = Recipe.list
      end
      it "class ActiveRecord::Relation" do
        @recipes.should be_instance_of ActiveRecord::Relation
      end
      it "element is Recipe" do
        @recipes.first.should be_instance_of Recipe
      end
      it "select view_count is higiest" do
        @recipes.first.id.should == 6
      end
    end
    context "recipe_food_id parameter" do
      before do
        @recipes = Recipe.list( recipe_food_id: 10 )
      end
      it "class ActiveRecord::Relation" do
        @recipes.should be_instance_of ActiveRecord::Relation
      end
      it "element is Recipe" do
        @recipes.first.should be_instance_of Recipe
      end
      it "select created_at is nearest" do
        @recipes.first.id.should == 121
      end
    end
    context "recipe_food_genre_id parameter" do
      before do
        @recipes = Recipe.list( recipe_food_genre_id: 2 )
      end
      it "class ActiveRecord::Relation" do
        @recipes.should be_instance_of ActiveRecord::Relation
      end
      it "element is Recipe" do
        @recipes.first.should be_instance_of Recipe
      end
      it "select created_at is nearest" do
        @recipes.first.id.should == 136
      end
    end
    context "recipe_food_name parameter" do
      context "recipe_food_name" do
        before do
          @recipes = Recipe.list( recipe_food_name: "Khoai /Củ" ).page(1).per(5)
        end
        it "recipe_food_id is equal to recipe_food_name's house" do
          @recipes.first.recipe_food_id.should == 2
        end
      end
    end
    context "sort by new" do
      before do
        @recipes = Recipe.list( { recipe_food_genre_id: 1 }, "new" )
      end
      it "select created_at is nearest element" do
        @recipes.first.id.should == 12
      end
    end
    context "sort by ranking" do
      before do
        @recipes = Recipe.list( { recipe_food_genre_id: 1 }, "ranking" )
      end
      it "select created_at is nearest element" do
        @recipes.first.id.should == 6
      end
    end
  end

  describe ".food_genre_recommend_recipe" do
    let(:prms) do
      h = {"order_mode"=>"new", "recipe_food_id"=>"1"}
      ActiveSupport::HashWithIndifferentAccess.new(h)
    end
    before do
      @recomment_food_genre_recipe = Recipe.food_genre_recommend_recipe(prms)
    end
    it "一番最近に作られたレシピを返す" do
      @recomment_food_genre_recipe.id == 12
    end
  end

  describe "#publication" do
    before do
      @genre = RecipeFoodGenre.find(1)
      @recipe = Recipe.find(15)
      @recipe.publication
    end
    it "公開ステータスを非公開から公開に変更する" do
      @recipe.public.should be_true
    end
    it "ジャンルに属しているレシピの数をインクリメントする" do
      RecipeFoodGenre.find(1).amount.should == @genre.amount+1
    end
  end
end

