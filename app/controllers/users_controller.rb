# encoding: utf-8

class UsersController < ApplicationController
  before_filter :authenticate_user!

  def stop_confirm
  end

  # user account is exist, but all recipes, profiles is unpubliced
  def stop
    current_user.stop

    redirect_to action:"stoped"
  end

  def stoped
  end

  def registrated
  end
end
