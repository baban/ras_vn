# encoding: utf-8

class ShopController < ApplicationController
  def show
    @shop = Shop.find(params[:id])
  end

  def meny
  end

  def map
  end

  def reserve
  end
end
