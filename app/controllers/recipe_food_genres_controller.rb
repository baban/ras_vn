# encoding: utf-8

class RecipeFoodGenresController < ApplicationController
  def index
    if params[:recipe_food_genre_id]
      @food_genres = RecipeFoodGenre.where( " id = ? ", params[:recipe_food_genre_id] ).includes(:recipe_foods)
    else
      @food_genres = RecipeFoodGenre.includes(:recipe_foods)
    end
  end
end
