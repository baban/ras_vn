# encoding: utf-8

require 'spec_helper'

describe Recipe do
  fixtures :recipes

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

  describe ".list" do
    fixtures :recipe_food_genres, :recipe_foods
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
    context "sort by new" do
      before do
        @recipes = Recipe.list( { recipe_food_genre_id: 1 }, "new" )
      end
      it "select created_at is nearest element" do
        @recipes.first.id.should == 11
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
end
