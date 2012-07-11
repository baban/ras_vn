# encoding: utf-8

class TopController < ApplicationController
  def index
    toppage = ToppageContent.first
    @recomment_food_genre_recipe = Recipe.find_by_id(toppage.recommend_recipe_genre_id)
    @recomment_recipe = Recipe.find_by_id(toppage.recommend_recipe_id)

    @food_genres = RecipeFoodGenre.includes(:recipe_foods)

    @ranking = RecipeRanking.topics
    @recipe_ranking = RecipeRanking.topics
    @foodstuff_ranking = RecipeFoodGenreRanking.topics
  end

  def restaurant
    @food_genre = FoodGenre.all
  end

  def recipe
  end
end
