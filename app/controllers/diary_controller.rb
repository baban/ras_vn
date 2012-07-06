# encoding: utf-8

class DiaryController < ApplicationController
  def index
    id = params[:user_id]
    @user = User.find_by_id(id)
    @diary = @user.diary
  end

  def show
    @diary = Diary.find(params[:id])
  end

  def new
  end

  def create
    diary = Diary.new
    diary.attributes= params[:diary]
    diary.save

    redirect_to :index, notice:"記事を作成しました"
  end

  def edit
  end

  def update
    diary = Diary.find(params[:id])
    diary.attributes= params[:diary]
    diary.save

    redirect_to :index, notice:"記事を更新しました"
  end

  def destroy
    Diary.find(params[:id]).destroy
    
    redirect_to :index, notice:"削除が完了しました"
  end
end
