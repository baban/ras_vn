# encoding: utf-8

class ProfileController < ApplicationController
  before_filter :authenticate_user!

  def show
    @info = current_user.info
  end

  def edit
    @info = current_user.info
  end

  def update
  end
end
