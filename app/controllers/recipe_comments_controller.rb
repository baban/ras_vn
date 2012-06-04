# encoding: utf-8

class RecipeCommentsController < ApplicationController
  def create
    comment =params[:recipe_comments]
    RecipeComment.create( recipe_id: comment[:recipe_id], user_id: current_user.id, content: comment[:content] )
    redirect_to controller:"recipes", action:"show", id: comment[:recipe_id], anchor:"recipe_comments"
  end
end
