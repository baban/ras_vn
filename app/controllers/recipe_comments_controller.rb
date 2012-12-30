# encoding: utf-8

class RecipeCommentsController < ApplicationController
  def create
    comment = params[:recipe_comment]
    comment[:user_id] = current_user.id
    @comment = RecipeComment.new
    @comment.attributes = comment
    @comment.save
    redirect_to controller:"recipes", action:"show", id: comment[:recipe_id], anchor:"recipe_comments"
  end
end
