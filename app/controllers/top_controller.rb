# encoding: utf-8

class TopController < ApplicationController
  def index
    top_content = ToppageContent.first
    @recomment_food_genre_recipe = Recipe.find_by_id(top_content.recommend_recipe_genre_id)
    @recomment_recipe = Recipe.find_by_id(top_content.recommend_recipe_id)

    @food_genres = RecipeFoodGenre.includes(:recipe_foods)

    @ranking = RecipeRanking.topics
    @recipe_ranking = RecipeRanking.topics
    @foodstuff_ranking = RecipeFoodGenreRanking.topics
  end
end
