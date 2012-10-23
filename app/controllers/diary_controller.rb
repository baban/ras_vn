# encoding: utf-8

class DiaryController < ApplicationController
  helper_method :my_diary?

  def index
    id = params[:user_id]
    @page = params[:page] || 1
    @user = User.find_by_id(id) || current_user
    @diary = @user.diaries.page(@page)
  end

  def show
    @diary = Diary.find(params[:id])
  end

  def new
    @diary = Diary.new
  end

  def create
    diary = Diary.new
    diary.attributes= params[:diary]
    diary.user_id= current_user.id
    diary.save

    redirect_to action:"edit", id: diary.id
  end

  def edit
    @diary = Diary.find(params[:id])
  end

  def update
    diary = Diary.find(params[:id])
    diary.attributes= params[:diary]
    diary.save

    redirect_to( { action:"show", id: diary.id }, notice: t(:update_notice, scope:"views.diary") )
  end

  def destroy
    Diary.find(params[:id]).destroy
    
    redirect_to( { action: "index" }, notice: t(:diary_notice, scope:"views.diary") )
  end

  private 
  def my_diary?
    !!Diary.find_by_user_id( params[:user_id] )
  end
end
