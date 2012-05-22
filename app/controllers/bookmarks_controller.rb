# encoding: utf-8

class BookmarksController < ApplicationController
  before_filter :authenticate_user!

  def index
    @shops = Bookmark.list
  end

  def create
  end

  def deatroy
  end
end
