# encoding: utf-8

class BookmarksController < ApplicationController
  before_filter :authenticate_user!

  def index
    @recipes = current_user.bookmarked_recipes.page(params[:page] || 1)
  end

  def create
    Bookmark.create( recipe_id: params[:id], user_id: params[:user_id] )
  end

  def destroy
    Bookmark.find_by_recipe_id_and_user_id( recipe_id: params[:id], user_id: params[:user_id] ).delete
  end
end
