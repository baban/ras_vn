# encoding: utf-8

class RecipeRanking < ActiveRecord::Base
  paginates_per 10

  #scope :topics, ->{ where("").joins(:recipes).on( " recipe_rankings.recipes_id = recipes.id" ) }

  def self.topics
    ids = page(1).per(2).all.map(&:recipe_id)
    Recipe.where( "id in (?) ", ids )
  end

  # create ranking
  def self.aggrigate
    # ranking sorted by only page view_count
    ranking = Recipe.order("view_count desc").limit(10)
    ranking.map{ |recipe| self.create( recipe_id: recipe.id ) }
  end
end
