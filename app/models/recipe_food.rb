# encoding: utf-8

class RecipeFood < ActiveRecord::Base
  belongs_to :recipe_food_genre
  has_many :recipes

  scope :show_top, ->{ where(" show_top = true ") }

  def genre
    RecipeFoodGenre.find_by_id( self.try(:recipe_food_genre_id) )
  end
end
