# endoing: utf-8

class MypagesController < ApplicationController
  before_filter :authenticate_user!

  def index
    @profile = current_user.profile
    @visibility = @profile.visibility
  end

  def recipes
    @recipes = current_user.recipes.page(params[:page] || 1)
  end
end
