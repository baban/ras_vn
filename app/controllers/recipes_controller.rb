# encoding: utf-8

class RecipesController < ApplicationController
  before_filter :authenticate_user!,   except:[:index,:show]
  #before_filter :editable_user_filter, only:[:edit,:update,:destroy]
  before_filter :advertisement_filter, except:[:create,:destroy]
  before_filter :sidebar_ranking_filter

  helper_method :loved?, :bookmarked?, :my_recipe?

  def index
    @recipes = RecipeSearcher.search( params.merge( user_id: (current_user && current_user.id).to_i ) )
  end

  def show
    @recipe = Recipe.find(params[:id])
    @recipe_comment = RecipeComment.new

    @bookmark = (current_user && Bookmark.find_by_recipe_id_and_user_id( params[:id], current_user.id )) || Bookmark.new

    @recipe.view_count_increment!
  end

  def new
    @recipe = Recipe.new
  end

  def create
    @recipe = Recipe.new
    @recipe.attributes= params[:recipe]
    @recipe.user_id = current_user.id
    @recipe.save
    
    @draft = RecipeDraft.new
    @draft.attributes= params[:recipe]
    @draft.recipe_id= @recipe.id
    @draft.user_id = current_user.id
    @draft.save

    redirect_to( { action:'edit', id: @recipe.id }, notice: "create completed" )
  end

  def edit
    @recipe = RecipeDraft.find(params[:id])
    @steps  = @recipe.edit_steps
    @foodstuffs  = @recipe.edit_foodstuffs
  end

  def update
    @recipe = RecipeDraft.find(params[:id])

    @foodstuffs = params[:foodstuffs]
      .select{ |h| h["name"].blank?.! }
      .map{ |h| RecipeFoodstuffDraft.new(name: h["name"], amount: h["amount"]) }
    logger.info @foodstuffs.inspect
    @recipe.foodstuffs= @foodstuffs

    @steps = params[:recipe_steps]
      .select{ |o| o[:content].blank?.! }
      .map { |v| RecipeStepDraft.new(v) }
    @recipe.steps= @steps

    @recipe.attributes= params[:recipe]
    @recipe.user_id= current_user.id
    @recipe.save

    # copy_draft
    @recipe.copy_public

    if params[:edit]
      flash[:notice] = t(:tmp_save, scope:"views.recipes.edit")
      render action: "edit"
    else
      redirect_to( { action:"show", id: params[:id] }, notice: t(:save_complete, scope:"views.recipes.edit") )
    end
  end

  def destroy
    @recipe = Recipe.find(params[:id])
    @recipe.delete
    redirect_to action:'index'
  end

  def love
    @recipe = Recipe.love( id: params[:id], user_id: params[:user_id]  )
    respond_to do |format|
      format.json { render json: { id: params[:id], count: @recipe.love_count } }
    end
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

  def loved?
    !!RecipeLoveLog.find_by_user_id_and_recipe_id( current_user.id, params[:id] )
  end

  def bookmarked?
    !!current_user && !!Bookmark.find_by_user_id_and_recipe_id(current_user.id, params[:id])
  end

  def my_recipe?
    recipe = Recipe.find_by_id(params[:id])
    recipe && current_user && (recipe.user_id == current_user.id)
  end
end
