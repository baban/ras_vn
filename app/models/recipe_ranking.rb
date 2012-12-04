# encoding: utf-8

class RecipeRanking < ActiveRecord::Base
  paginates_per 10

  def self.topics
    Recipe.where( id: page(1).per(2).pluck(:recipe_id) )
  end

  # create ranking
  def self.aggrigate
    # ranking sorted by only page view_count
    ranking = Recipe.order("view_count desc").limit(10)
    ranking.map{ |recipe| self.create( recipe_id: recipe.id ) }
  end
end
