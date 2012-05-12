# encoding: utf-8

class ShopController < ApplicationController
  def index
    @shops = Searcher.search
  end

  def show
    @shop = Shop.find(params[:id])
  end

  def menu
    @shop = Shop.find(params[:id])
  end

  def map
    @shop = Shop.find(params[:id])
  end

  def reserve
    @shop = Shop.find(params[:id])
  end
end