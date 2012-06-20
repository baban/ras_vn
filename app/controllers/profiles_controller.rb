# encoding: utf-8

class ProfilesController < ApplicationController
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
    @profile.attributes = params[:user_profile]

    @visibility = @profile.visibility
    @visibility.attributes = params[:user_profile_visibility]

    return render(action:'edit') if @profile.valid?.! or @visibility.valid?.!

    @profile.save!
    @visibility.save!

    # redirect_to action:'show'
    redirect_to controller:"mypage", action:"index"
  end
end
