# encoding: utf-8

class RecipeController < ApplicationController
  def index
    @recipes = Recipe.all
  end

  def show
    @recipe = Recipe.find(params[:id])
  end

  def edit
  end

  def create
  end

  def destroy
  end

  def new
  end
end
