# encoding: utf-8

class UsersController < ApplicationController
  def index
  end

  def show
    @user = User.find(params[:id])
    @profile = @user.profile
    @visibility = @profile.visibility
  end
end
