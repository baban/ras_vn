# encoding: utf-8

class BookmarksController < ApplicationController
  before_filter :authenticate_user!

  def index
    @recipes = current_user.bookmarked_recipes.page(params[:page] || 1)
  end

  def create
    Bookmark.create( user_id: current_user.id, recipe_id: params[:id] )
    redirect_to controller:"recipes", action:"show", id: params[:id]
  end

  def deatroy
  end
end
