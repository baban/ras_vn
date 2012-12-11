# encoding: utf-8

require 'spec_helper'

describe RecipeDraft do
  fixtures :recipes, :recipe_drafts

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

