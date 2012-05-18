# encoding: utf-8

class RecipeStepsController < ApplicationController
  def update
    @recipe = Recipe.find(params[:id])
    steps = params[:recipe_steps].values.select{ |v| v.blank?.! }.map{ |v| RecipeStep.new(context: v) }
    @recipe.recipe_steps= steps
    @recipe.save!
    @recipe.steps
  end
end
