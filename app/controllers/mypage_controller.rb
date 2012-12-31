# endoing: utf-8

class MypageController < ApplicationController
  helper_method :myself?, :followed?
  before_filter :authenticate_user!

  def index
    @profile = current_user.profile
    @visibility = @profile.visibility
  end

  def recipes
    @recipes = current_user.recipes.order( "created_at DESC" ).page(params[:page] || 1)
  end

  def recipe_comments
    @comments = current_user.recipe_comments.page(params[:page] || 1)
  end

  def diary
    id = params[:user_id]
    @page = params[:page] || 1
    @user = current_user
    @diary = @user.diaries.page(@page)
  end

  def follow
    followers = Follower.where( user_id: current_user.id ).select(:follower_id)
    @profiles = UserProfile.where( " user_id in (#{followers.to_sql}) " ).page( params[:page] || 1 )
  end

  def follower
    @follows = Follower.where( follower_id: current_user.id ).page( params[:page] || 1 )
  end

  # retire description
  def retire
  end
  
  private
  def myself?
    return true if current_user.id == params[:id]
    false
  end

  def followed?
    !!Follower.find_by_user_id_and_follower_id( current_user.id, params[:id] )
  end
end
