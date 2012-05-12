# encoding: utf-8

class TopController < ApplicationController
  def index
    @food_genre = FoodGenreMaster.all
  end

  def recipi
  end

  def restrant
  end

end
