# encoding: utf-8

class RecipesController < ApplicationController
  before_filter :authenticate_user!,   except: %W[index show]
  before_filter :publiced_filter,      only: %W[show]
  before_filter :editable_user_filter, only: %W[edit update destroy publication]

  helper_method :loved?, :bookmarked?, :my_recipe?

  # paly_holders is using in view
  PLAY_HOLDERS = [
    ["Ví dụ: thịt heo", "200g"],
    ["Ví dụ: hành tím", "50g"],
    ["Ví dụ: nước mắm", "1 thìa"],
    ["Ví dụ: đường", "10g"],
    ["Ví dụ: dầu ăn", "1/2 thìa"],
  ]

  def index
    redirect_to recipe_food_genres_url
  end

  def show
    @recipe ||= Recipe.find(params[:id])

    @recipe_comment = RecipeComment.new
    @comments = @recipe.comments
    @bookmark = Bookmark.where( recipe_id: params[:id], user_id: current_user.try(:id) ).first || Bookmark.new

    @recipe.view_count_increment!
    RecipeViewLog.add( @recipe.id )
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
    @playholders = PLAY_HOLDERS
    @recipe = Recipe.find(params[:id])
    @draft = @recipe.draft
    @foodstuffs = @draft.edit_foodstuffs
    @steps = @draft.edit_steps
  end

  def update
    @playholders = PLAY_HOLDERS

    @recipe = Recipe.find(params[:id])
    @draft = @recipe.draft
    @draft.post( params, current_user )

    @foodstuffs = RecipeFoodstuffDraft.post_filter( params[:foodstuffs] )
    @steps = RecipeStepDraft.post_filter( params[:recipe_steps], @draft.steps )

    return render action:"edit" if (not @draft.valid?) or @steps.map(&:valid?).include?(false) or @foodstuffs.map(&:valid?).include?(false)

    @draft.foodstuffs= @foodstuffs
    @draft.steps= @steps
    @draft.calc_total_calory
    @draft.save

    if params[:edit]
      redirect_to( { action: "edit", id: @recipe.id }, notice: t(:tmp_save, scope:"views.recipes.edit") )
    else
      ActiveRecord::Base.transaction do
        # recipe_drafts data is copying to recipes table
        @draft.copy_public
        unless @recipe.public
          @recipe.publication( true )
          Stream.push( Stream::ADD_RECIPE, current_user.id, @recipe )
        end
      end
      redirect_to( { action: "show", id: @recipe.id }, notice: t(:save_complete, scope:"views.recipes.edit") )
    end
  end

  # if love button is cliced!
  # this action is called and, return json value set
  def love
    @recipe = Recipe.love( id: params[:id], user_id: params[:user_id]  )
    render json: { id: params[:id], count: @recipe.love_count }, status: 200
  end

  def publication
    @recipe = Recipe.find(params[:id])
    @recipe.publication( (params[:public]=='true') )

    redirect_to( { controller:"mypage", action:"recipes" }, notice: "status changed" )
  end

  def youtube
    prms = { vq: params[:vq], :"max-results" => 5, alt: "json" }.map{ |k,v| "#{k}=#{v}" }*"&"
    url = "http://gdata.youtube.com/feeds/api/videos/?#{prms}"
    logger.info url
    response = Faraday.get url
    logger.info response.body
    render text: response.body, status: 200
  end

  private
  def publiced_filter
    @recipe = Recipe.where( id: params[:id] ).first
    return render(action:"unpubliced_recipe") if @recipe.status == Recipe::Status::REJECT
    return render(action:"unpubliced_recipe") if (not @recipe.try(:public)) and @recipe.user_id != current_user.try(:id)
  end

  def editable_user_filter
    return redirect_to( action:'index' ) unless params[:id]
    return redirect_to( recipes_url, alert: t("views.recipes.create.other_user_recipe_alert") ) unless my_recipe?
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

