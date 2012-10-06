# encoding: utf-8

class TopController < ApplicationController
  include TrackerFilter

  before_filter :sidebar_filter
  def index
    logger.info session.inspect
    top_content = ToppageContent.first
    @recomment_food_genre_recipe = top_content && Recipe.find_by_id(top_content.recommend_recipe_genre_id)
    @recomment_food = @recomment_food_genre_recipe && RecipeFood.find_by_id(@recomment_food_genre_recipe.recipe_food_id)

    @recommend_recipe = Recipe.find_by_id(top_content.recommend_recipe_id)

    @food_genres = RecipeFoodGenre.includes(:recipe_foods).where( recipe_foods:{ show_top: true } )

    @ranking = RecipeRanking.topics

    @newsfeeds = Newsfeed.topics
  end
end
