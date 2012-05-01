# encoding: utf-8

class BookmarkController < ApplicationController
  def index
    @shops = Bookmark.list
  end

  def create
  end

  def deatroy
  end
end
