# encoding: utf-8

class RestaurantProfileController < ApplicationController
  def top_photo
    @restaurant_proile = RestaurantProfile.find(params[:id])
    send_data(@restaurant_proile.top_photo, disposition:"inline", type:"image/jpg")
  end

end
