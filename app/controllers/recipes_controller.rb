# encoding: utf-8

class RecipesController < ApplicationController
  before_filter :authenticate_user!,   except: %W[index show]
  before_filter :editable_user_filter, only: %W[edit update destroy]
  before_filter :advertisement_filter, except: %W[create destroy]

  helper_method :loved?, :bookmarked?, :my_recipe?

  def index
    redirect_to recipe_food_genres_url
  end

  def show
    @recipe = Recipe.find(params[:id])
    @recipe_comment = RecipeComment.new

    @bookmark = Bookmark.find_by_recipe_id_and_user_id( params[:id], current_user.try(:id) ) || Bookmark.new

    @recipe.view_count_increment!
  end

  def new
    @recipe = Recipe.new
  end

  def create
    ActiveRecord::Base.transaction do
      @recipe = Recipe.new
      @recipe.attributes= params[:recipe]
      @recipe.user_id = current_user.id

      return render(action:"new") unless @recipe.valid?
      @recipe.save

      @draft = RecipeDraft.new
      @draft.attributes= params[:recipe]
      @draft.recipe_id= @recipe.id
      @draft.user_id = current_user.id
      @draft.save

      Stream.push( Stream::ADD_RECIPE, current_user.id, @recipe )
    end

    redirect_to( { action:'edit', id: @recipe.id }, notice: "create completed" )
  end

  def edit
    @recipe_origin = Recipe.find(params[:id])
    @recipe = @recipe_origin.draft
    @foodstuffs  = @recipe.edit_foodstuffs
    @steps  = @recipe.edit_steps
  end

  def update
    @recipe_origin = Recipe.find(params[:id])
    @recipe = @recipe_origin.draft

    @recipe.foodstuffs= RecipeFoodstuffDraft.post_filter( params[:foodstuffs] )
    @recipe.steps= RecipeStepDraft.post_filter( params[:recipe_steps] )

    @recipe.attributes= params[:recipe]
    @recipe.user_id= current_user.id
    
    @recipe.recipe_food_id= RecipeFood.create( recipe_food_genre_id: params[:recipe_genre_selecter], name: params[:new_food_genre] ).id if params[:new_food_genre]
    @recipe.save

    # recipe_drafts data is copying to recipes table
    @recipe.copy_public

    if params[:edit]
      redirect_to( { action: "edit", id: params[:id] }, notice: t(:tmp_save, scope:"views.recipes.edit") )
    else
      redirect_to( { action: "show", id: params[:id] }, notice: t(:save_complete, scope:"views.recipes.edit") )
    end
  end

  # if love button is cliced!
  # this action is called and, return json value set
  def love
    @recipe = Recipe.love( id: params[:id], user_id: params[:user_id]  )
    respond_to do |format|
      format.json { render json: { id: params[:id], count: @recipe.love_count } }
    end
  end

  private
  def editable_user_filter
    return redirect_to( action:'index' ) unless params[:id]
    return redirect_to( recipes_url, alert: t("views.recipes.create.other_user_recipe_alert") ) unless my_recipe?
  end

  # get advartisement banner image and description
  def advertisement_filter
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
