# encoding: utf-8

class BookmarksController < ApplicationController
  before_filter :authenticate_user!

  def index
    @recipes = Recipe.where(nil).page(params[:page] || 1)
  end

  def create
  end

  def deatroy
  end
end
