# encoding: utf-8

class RecipeCommentsController < ApplicationController
  def create
    comment = params[:recipe_comment]
    comment[:user_id] = current_user.id
    @comment = RecipeComment.new
    @comment.attributes = comment
    @comment.save
    dst = { controller:"recipes", action:"show", id: comment[:recipe_id], anchor:"recipe_comments" }
    return redirect_to( dst, flash: { error_explanation: @comment.errors.full_messages.map{ |e| "<li>#{e}</li>" }.join('') } ) unless @comment.valid?
    redirect_to dst
  end
end
