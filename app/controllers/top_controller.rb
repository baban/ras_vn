# encoding: utf-8

class TopController < ApplicationController
  before_filter :sidebar_ranking_filter
  def index
    logger.info session.inspect
    top_content = ToppageContent.first
    @recomment_food_genre_recipe = Recipe.find_by_id(top_content.recommend_recipe_genre_id)
    @recomment_food = RecipeFood.find_by_id(@recomment_food_genre_recipe.try(:recipe_food_id).to_i)

    @recommend_recipe = Recipe.find_by_id(top_content.recommend_recipe_id)

    @food_genres = RecipeFoodGenre.includes(:recipe_foods).where( recipe_foods:{ show_top: true } )

    @ranking = RecipeRanking.topics
  end
end
