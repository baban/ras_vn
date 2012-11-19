# encoding: utf-8

class RecipeFoodsController < ApplicationController
  before_filter :authenticate_user!, only:[:new,:create]

  def index
    @recomment_food_genre_recipe = Recipe.top_content
    @order_mode = params[:order_mode] || "ranking"
    @food_genre = RecipeFoodGenre.choice(params)
    @recipes = Recipe.list( params, @order_mode ).page( params[:page] || 1 ).per(5)
  end

  def new
    @food_genres = RecipeFoodGenre.unscoped
    @recipe_food = RecipeFood.new
  end

  def create
    @recipe_food = RecipeFood.new
    @recipe_food.attributes = params[:recipe_food]
    @recipe_food.save
    
    redirect_to action:"new"
  end
end

