# encoding: utf-8

class KitchensController < ApplicationController
  def show
    @user = User.find(params[:id])
    @profile = @user.profile
    @visibility = @profile.visibility
    @recipes = @user.recipes.topics
  end

  def recipes
    @user = User.find(params[:id])
    @profile = @user.profile
    @visibility = @profile.visibility
    @recipes = @user.recipes.visibles.page(params[:page] || 1)
  end
end
