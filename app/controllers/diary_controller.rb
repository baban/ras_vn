# encoding: utf-8

class DiaryController < ApplicationController
  def index
    id = params[:user_id]
    @user = User.find_by_id(id)
    @articles = @user.diary
  end

  def show
  end

  def create
  end

  def edit
  end

  def update
  end

  def destroy
  end
end
