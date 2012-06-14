# encoding: utf-8

class ProfileController < ApplicationController
  before_filter :authenticate_user!

  def show
    @info = current_user.profile
  end

  def edit
    @info = current_user.profile
  end

  def update
    @info = current_user.profile
    @info.attributes = params[:user_info]

    return render(action:'edit') unless @info.valid?

    @info.save
    redirect_to action:'show'
  end
end
