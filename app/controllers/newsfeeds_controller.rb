class NewsfeedsController < ApplicationController
  def index
    @newsfeeds = Newsfeed.page(params[:page] || 1)
  end

  def show
    @newsfeed = Newsfeed.find(params[:id])
  end
end
