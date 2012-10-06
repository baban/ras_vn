# encoding: utf-8

class RecipeFoodsController < ApplicationController
  before_filter :authenticate_user!,   except:[:new,:create]
  before_filter :sidebar_filter

  def index
    if params[:recipe_food_genre_id]
      @food_genres = RecipeFoodGenre.where( " id = ? ", params[:recipe_food_genre_id] ).includes(:recipe_foods)
    else
      @food_genres = RecipeFoodGenre.includes(:recipe_foods)
    end
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
