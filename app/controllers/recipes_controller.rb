# encoding: utf-8

class RecipesController < ApplicationController
  before_filter :authenticate_user!,   except:[:index,:show]
  #before_filter :editable_user_filter, only:[:edit,:update,:destroy]
  before_filter :advertisement_filter, except:[:create,:destroy]

  def index
    @recipes = RecipeSearcher.search(params)
  end

  def show
    load_content_footer_data

    @recipe = Recipe.find(params[:id])
    @recipe_comment = RecipeComment.new

    @recipe.view_count_increment!
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

  def edit
    @recipe = Recipe.find(params[:id])
    @steps  = @recipe.edit_steps
    @foodstuffs  = @recipe.edit_foodstuffs
  end

  def update
    @recipe = Recipe.find(params[:id])

    @foodstuffs = params[:foodstuffs]
      .select{ |h| h["name"].blank?.! }
      .map{ |h| RecipeFoodstuff.new(name: h["name"], amount: h["amount"]) }
    logger.info @foodstuffs.inspect
    @recipe.recipe_foodstuffs= @foodstuffs

    @steps = params[:recipe_steps]
      .select{ |o| o[:content].blank?.! }
      .map { |v| RecipeStep.new(v) }
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

  def destroy
    @recipe = Recipe.find(params[:id])
    @recipe.delete
    redirect_to action:'index'
  end

  def like
    Recipe.like( params[:id], current_user )

    redirect_to action: "show", id: params[:id]
  end

  private
  def editable_user_filter
    # TODO: 管理者はアクセスできるようにしておく
    return redirect_to(action:'index') unless params[:id]
    
    @recipe = Recipe.find(params[:id])
    return redirect_to( { action:"index" }, flash:{ alert:"you cannot edit this recipe" }) unless my_recipe?
  end

  def advertisement_filter
    # お客に合わせた広告を取得できる様に余地を残しておく
    @advertisement = RecipeAdvertisement.choice
  end

end
