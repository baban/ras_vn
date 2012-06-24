# encoding: utf-8

class ApplicationController < ActionController::Base
  protect_from_forgery

  helper_method :my_recipe?

  def auth
    @user = current_user
  end

  private
  def my_recipe?
    @recipe and (@recipe.user_id == current_user.id)
  end

  def load_content_footer_data
    @ranking = RecipeRanking.topics
    @recipe_ranking = RecipeRanking.topics
    @foodstuff_ranking = RecipeFoodstuffRanking.topics
  end
end
