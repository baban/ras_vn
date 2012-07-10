# encoding: utf-8

class RecipeFood < ActiveRecord::Base
  belongs_to :recipe_food_genre
  has_many :recipes
end
