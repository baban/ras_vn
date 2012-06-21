# encoding: utf-8

class ChefsController < ApplicationController
  def show
    @user = User.find(params[:id])
    @profile = @user.profile
    @visibility = @profile.visibility
    @recipes = @user.recipes
  end
end
