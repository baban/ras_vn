# encoding: utf-8

class BookmarksController < ApplicationController
  before_filter :authenticate_user!

  def index
    @recipes = current_user.bookmarked_recipes.page(params[:page] || 1).per(12)
  end

  def create
  end

  def deatroy
  end
end
