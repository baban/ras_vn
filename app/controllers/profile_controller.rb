# encoding: utf-8

class ProfileController < ApplicationController
  before_filter :authenticate_user!

  def show
    @profile = current_user.profile
    @visibility = @profile.visibility
  end

  def edit
    @profile = current_user.profile
    @visibility = @profile.visibility
  end

  def update
    @profile = current_user.profile
    @profile.attributes = params[:user_info]

    return render(action:'edit') unless @profile.valid?

    @profile.save
    redirect_to action:'show'
  end
end
