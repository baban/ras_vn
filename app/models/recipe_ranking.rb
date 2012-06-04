# encoding: utf-8

class RecipeRanking < ActiveRecord::Base
  paginates_per 10

  #scope :topics, ->{ where("").joins(:recipes).on( " recipe_rankings.recipes_id = recipes.id" ) }

  def self.topics
    ids = page(1).per(2).all.map(&:recipe_id)
    Recipe.where( "id in (?) ", ids )
  end
end
