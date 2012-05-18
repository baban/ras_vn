# encoding: utf-8

class RestaurantsController < ApplicationController
  def index
    @restaurants = RestaurantSearcher.search(params)
  end

  def show
    @restaurant = Restaurant.find(params[:id])
  end

  def menu
    @restaurant = Restaurant.find(params[:id])
  end

  def map
    @restaurant = Restaurant.find(params[:id])
  end

  def reserve
    @restaurant = Restaurant.find(params[:id])
  end
end
