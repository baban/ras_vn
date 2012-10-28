# endoing: utf-8

class MypageController < ApplicationController
  before_filter :authenticate_user!

  def index
    @profile = current_user.profile
    @visibility = @profile.visibility
  end

  def recipes
    @recipes = current_user.recipes.page(params[:page] || 1)
  end

  def diary
    id = params[:user_id]
    @page = params[:page] || 1
    @user = current_user
    @diary = @user.diaries.page(@page)
 end
end
