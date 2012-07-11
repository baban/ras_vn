# encoding: utf-8

class ApplicationController < ActionController::Base
  protect_from_forgery

  helper_method :my_recipe?, :current_omniuser, :login?

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
    @foodstuff_ranking = RecipeFoodGenreRanking.topics
  end

  # Omniauthでのログイン状況確認
  private
  def current_omniuser
    @current_omniuser ||= Omniuser.find_by_id(session[:user_id]) if session[:user_id]
  end

  def login?
    !!current_user
  end
end
