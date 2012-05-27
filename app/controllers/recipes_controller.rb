# encoding: utf-8

class RecipesController < ApplicationController
  before_filter :authenticate_user!, except:[:index,:show,:image]

  def index
    @recipes = RecipeSearcher.search(params)
  end

  def show
    @recipe = Recipe.find(params[:id])
  end

  def image
    @recipe = Recipe.find(params[:id])
    send_data(@recipe.image, disposition:"inline", type:"image/jpg")
  end

  def new
    @recipe = Recipe.new
  end

  def create
    @recipe = Recipe.new
    @recipe.attributes= params[:recipe]
    @recipe.user_id= current_user.id
    @recipe.save
    redirect_to( {action:'edit', id: @recipe.id }, flash:{ notice: "update completed" })
  end

  # TODO: 作成者か管理者しか編集できないようにする
  def edit
    @recipe = Recipe.find(params[:id])
    @steps  = @recipe.edit_steps
    @foodstuffs  = @recipe.edit_foodstuffs
  end

  # TODO: 作成者か管理者しか編集できないようにする
  def update
    @recipe = Recipe.find(params[:id])

    @foodstuffs = params[:foodstuffs]
      .select{ |h| h["name"].blank?.! }
      .map{ |h| RecipeFoodstuff.new(name: h["name"], amount: h["amount"]) }
    logger.info @foodstuffs.inspect
    @recipe.recipe_foodstuffs= @foodstuffs

    @steps = params[:steps].select{ |o| o.blank?.! }.map{ |v| RecipeStep.new(context: v) } 
    @recipe.recipe_steps= @steps

    @recipe.attributes= params[:recipe]
    @recipe.user_id= current_user.id
    @recipe.save

    if params[:commit] == "Save"
      flash[:notice] = "Update"
      render action:"edit"
    else
      redirect_to( {action:'index'}, flash:{ notice: "update completed" } )
    end
  end

  # TODO: 作成者か管理者しか編集できないようにする
  def destroy
    @recipe = Recipe.find(params[:id])
    @recipe.delete
    redirect_to action:'index'
  end
end
