# encoding: utf-8

class RecipeFoodGenreRanking < ActiveRecord::Base
  def self.topics
    ids = page(1).per(3).order(:id).pluck(:recipe_food_genre_id)
    RecipeFoodGenre.where( " id in (?) ", ids )
  end

  def self.aggrigation
    
  end
end
