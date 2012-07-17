# encoding: utf-8

class RecipeFoodGenreRanking < ActiveRecord::Base
  # get recipe ranking topics
  def self.topics
    # if today's ranking is going to be creating,
    # get yestaday's ranking
    ids = self
      .where( " ranked_at = ? or ranked_at = ? ", Date.today, Date.yesterday )
      .page(1).per(3).order(:ranked_at).order("point desc")
      .pluck(:recipe_food_genre_id)

    RecipeFoodGenre.where( " id in (?) ", ids )
  end

  # create todays recipe ranking
  def self.aggrigation
    # ranking is created sum of recipes view_count
    ranking = RecipeFoodGenre
      .joins(:recipe_foods => :recipes)
      .select(:recipe_food_genre_id)
      .select(RecipeFoodGenre.arel_table[:name])
      .select(Recipe.arel_table[:view_count].sum.as("id"))
      .group(:recipe_food_genre_id)
      .order("id desc")

    ranking.map do |rank|
      RecipeFoodGenreRanking.create( recipe_food_genre_id: rank.recipe_food_genre_id, point: rank.id, ranked_at: Date.today )
    end
  end
end
