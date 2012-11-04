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
end
