# encoding: utf-8

class RecipeFoodGenresController < ApplicationController
  def index
    @food_genres = RecipeFoodGenre.includes(:recipe_foods)
  end
end
