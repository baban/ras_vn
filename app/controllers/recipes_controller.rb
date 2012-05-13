# encoding: utf-8

class RecipesController < ApplicationController
  def index
    @recipes = Recipe.all
  end

  def show
    @recipe = Recipe.find(params[:id])
  end

  def new
    @recipe = Recipe.new
  end

  def edit
    @recipe = Recipe.find(params[:id])
    render action:'new'
  end

  def create
    @recipe = Recipe.new
    @recipe.attributes= params[:recipe]
    @recipe.save
    redirect_to action:'index'
  end

  def destroy
    @recipe = Recipe.find(params[:id])
    @recipe.delete
    redirect_to action:'index'
  end

end
