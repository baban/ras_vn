# encoding: utf-8

class ApplicationController < ActionController::Base
  protect_from_forgery

  def auth
    @user = current_user
  end
end
