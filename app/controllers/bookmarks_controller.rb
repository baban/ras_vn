# encoding: utf-8

class BookmarksController < ApplicationController
  before_filter :authenticate_user!

  def index
    @recipes = current_user.bookmarked_recipes.page(params[:page] || 1)
  end

  def create
    mark = Bookmark.new
    mark.attributes=params[:bookmark]
    mark.save

    redirect_to( { controller:"recipes", action:'show', id: params[:bookmark][:recipe_id] }, notice: "create completed" )
  end

  def update
    mark = Bookmark.find(params[:id]).delete

    redirect_to( { controller:"recipes", action:'show', id: params[:bookmark][:recipe_id] }, notice: "create completed" )
  end
end
