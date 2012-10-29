# encoding: utf-8

class KitchensController < ApplicationController
  helper_method :myself?, :followed?

  def show
    @user = User.find(params[:id])
    @profile = @user.profile
    @visibility = @profile.visibility
    @recipes = @user.recipes.topics
    @recipe_comments = @user.recipe_comments.topics
  end

  def recipes
    @user = User.find(params[:id])
    @profile = @user.profile
    @visibility = @profile.visibility
    @recipes = @user.recipes.visibles.page(params[:page] || 1)
  end

  def recipe_comments
    @user = User.find(params[:id])
    @profile = @user.profile
    @recipe_comments = @user.recipe_comments.page(params[:page] || 1)
  end

  def follow
    return if !params[:id] or !params[:user_id]

    if ret = !Follower.find_by_user_id_and_follower_id( params[:user_id], params[:id] )
      Follower.follow(   params[:user_id], params[:id] )
    else
      Follower.unfollow( params[:user_id], params[:id] )
    end

    respond_to do |format|
      format.json { render json: { id: params[:id], value: ret } }
    end
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
