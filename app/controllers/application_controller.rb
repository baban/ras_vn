# encoding: utf-8

class ApplicationController < ActionController::Base
  include FormHelper

  protect_from_forgery

  helper_method :my_recipe?, :current_omniuser, :login?

  def auth
    @user = current_user
  end

  private
  def my_recipe?
    @recipe and (@recipe.user_id == current_user.id)
  end

  # Omniauthでのログイン状況確認
  def current_omniuser
    @current_omniuser ||= Omniuser.find_by_id(session[:user_id]) if session[:user_id]
  end

  def login?
    !!current_user
  end

  def sidebar_filter
    @newsfeeds = Newsfeed.topics
  end
end
