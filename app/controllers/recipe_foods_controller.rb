# encoding: utf-8

class RecipeFoodsController < ApplicationController
  before_filter :authenticate_user!,   except:[:new,:create]

  def index
    if params[:recipe_food_genre_id]
      @food_genre = RecipeFoodGenre.where( " id = ? ", params[:recipe_food_genre_id] ).includes(:recipe_foods).first
    else
      @food_genre = RecipeFoodGenre.includes(:recipe_foods).first
    end
    food_genre_id = @food_genre.recipe_foods.pluck(:id)
    @recipes = Recipe.where( " recipe_food_id in (?) ", food_genre_id  ).order(" view_count DESC ").page( params[:page] || 1 ).per(5)
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
