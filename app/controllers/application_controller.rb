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
end
