# encoding: utf-8

#class UsersController < Devise::RegistrationsController
#class UsersController < ApplicationController
class UsersController < DeviseController
  def index
  end

  def show
    @user = User.find(params[:id])
    @profile = @user.profile
    @visibility = @profile.visibility
  end
end
