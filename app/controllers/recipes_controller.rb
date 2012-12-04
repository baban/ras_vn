# encoding: utf-8

class RecipesController < ApplicationController
  before_filter :authenticate_user!,   except: %W[index show]
  before_filter :publiced_filter,      only: %W[show]
  before_filter :editable_user_filter, only: %W[edit update destroy]
  before_filter :advertisement_filter, except: %W[create destroy]

  helper_method :loved?, :bookmarked?, :my_recipe?

  def index
    redirect_to recipe_food_genres_url
  end

  def show
    @recipe ||= Recipe.find(params[:id])
    @recipe_comment = RecipeComment.new
    @comments = @recipe.comments
    @bookmark = Bookmark.where( recipe_id: params[:id], user_id: current_user.try(:id) ).first || Bookmark.new

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

      @recipe.create_draft( params[:recipe] )
    end

    redirect_to( { action:'edit', id: @recipe.id }, notice: "create completed" )
  end

  def edit
    @play_holder = Array.new()
    @play_holder[0] = ["Ví dụ: thịt heo", "200g"]
    @play_holder[1] = ["Ví dụ: hành tím", "50g"]
    @play_holder[2] = ["Ví dụ: nước mắm", "1 thìa"]
    @play_holder[3] = ["Ví dụ: đường", "10g"]
    @play_holder[4] = ["Ví dụ: dầu ăn", "1/2 thìa"]
    
    @recipe = Recipe.find(params[:id])
    @draft = @recipe.draft
    @foodstuffs = @draft.edit_foodstuffs
    @steps = @draft.edit_steps
  end

  def update
    ActiveRecord::Base.transaction do
      @recipe = Recipe.find(params[:id])
      @draft = @recipe.draft
      @draft.attributes= params[:recipe]
      @draft.user_id= current_user.id    
      @draft.foodstuffs= RecipeFoodstuffDraft.post_filter( params[:foodstuffs] )
      @draft.steps= RecipeStepDraft.post_filter( params[:recipe_steps] )
      @draft.post_food_id( params )
      @draft.save

      # recipe_drafts data is copying to recipes table
      @draft.copy_public( params )
    end

    if params[:edit]
      redirect_to( { action: "edit", id: @recipe.id }, notice: t(:tmp_save, scope:"views.recipes.edit") )
    else
      redirect_to( { action: "show", id: @recipe.id }, notice: t(:save_complete, scope:"views.recipes.edit") )
    end
  end

  def publication
    @recipe = Recipe.find(params[:id])
    @recipe.public = true
    @recipe.save
    @recipe_food = RecipeFood.find( @recipe.recipe_food_id )
    @recipe_food_genre = RecipeFoodGenre.find(@recipe_food.recipe_food_genre_id)
    @recipe_food_genre.amount+=1
    @recipe_food_genre.save
    Stream.push( Stream::ADD_RECIPE, current_user.id, @recipe )

    redirect_to action:"show", id: @recipe.id
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
  def publiced_filter
    @recipe = Recipe.where( id: params[:id] ).first
    return redirect_to(recipe_food_genres_url, alert:"存在しないレシピです") if !@recipe.try(:public) and @recipe.user_id != current_user.try(:id)
  end

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

