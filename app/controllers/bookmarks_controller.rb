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

    redirect_to( { controller:"recipes", action:'show', id: params[:bookmark][:recipe_id] }, notice: t("page.bookmarks.create") )
  end

  def update
    mark = params[:bookmark]
    Bookmark.find_by_user_id_and_recipe_id(mark[:user_id], mark[:recipe_id]).delete

    redirect_to( { controller:"recipes", action:'show', id: mark[:recipe_id] }, notice: t("page.bookmarks.update") )
  end

  def destroy
    mark = Bookmark.find(params[:id]).delete
    redirect_to( { controller:"recipes", action:'show', id: params[:bookmark][:recipe_id] }, notice: "destroy completed" )
  end
end
