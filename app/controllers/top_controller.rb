# encoding: utf-8

class TopController < ApplicationController
  def index
    shop
    render action:'shop'
  end

  def shop
    @food_genre = FoodGenreMaster.all
  end

  def recipi
  end

  def restrant
  end

end
