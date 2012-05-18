# encoding: utf-8

class RecipesController < ApplicationController
  def index
    @recipes = RecipeSearcher.search(params)
  end

  def show
    @recipe = Recipe.find(params[:id])
  end

  def new
    @recipe = Recipe.new
  end

  def edit
    @recipe = Recipe.find(params[:id])
  end

  def create
    @recipe = Recipe.new
    @recipe.attributes= params[:recipe]
    @recipe.user_id= current_user.id
    @recipe.save
    redirect_to( {action:'edit', id: @recipe.id }, flash:{ notice: "update completed" })
  end

  def update
    @recipe = Recipe.new
    @recipe.attributes= params[:recipe]
    @recipe.user_id= current_user.id
    @recipe.save
    redirect_to( {action:'index'}, flash:{ notice: "update completed" } )
  end

  def destroy
    @recipe = Recipe.find(params[:id])
    @recipe.delete
    redirect_to action:'index'
  end
end
