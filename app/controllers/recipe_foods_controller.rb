# encoding: utf-8

class RecipeFoodsController < ApplicationController
  def index
    if params[:recipe_food_genre_id]
      @food_genres = RecipeFoodGgenre.where( " id = ? ", params[:recipe_food_genre_id] )
    else
      @food_genres = RecipeFoodGenre.all
    end
  end
end
