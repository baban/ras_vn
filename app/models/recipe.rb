# encoding: utf-8

class Recipe < ActiveRecord::Base
  acts_as_paranoid

  paginates_per 10

  ADD_RECIPE = 2

  module Status
    EDITING = 0
    OPEN    = 1
    REJECT  = 2 # if administrator is set reject, recipe is unpubliced
  end

  validates :title,        presence: true
  validates :recipe_image, presence: true

  has_one  :recipe_draft
  has_many :bookmarks
  has_many :recipe_foodstuffs
  has_many :recipe_steps
  has_many :recipe_comments

  belongs_to :recipe_ranking
  belongs_to :user

  accepts_nested_attributes_for :recipe_steps # use formtastic plug-in

  mount_uploader :recipe_image, RecipeImageUploader 

  alias :draft :recipe_draft
  alias :foodstuffs :recipe_foodstuffs
  alias :foodstuffs= :recipe_foodstuffs=
  alias :steps :recipe_steps
  alias :steps= :recipe_steps=
  alias :image :recipe_image

  scope :visibles, -> { where( "public = true" ).where( status: Status::OPEN ) }
  scope :topics, -> { visibles.page(1).per(2) }

  def food
    RecipeFood.whereid( id: self.recipe_food_id ).first
  end

  def chef
    @chef_cache ||= self.user
  end

  def chef=(v)
    @chef_cache = v
  end

  def chef_profile
    @chef_info_cache ||= UserProfile.where( user_id: self.user_id ).first
  end

  def chef_profile=(v)
    @chef_info_cache = v
  end

  def comments
    cmts = recipe_comments
    profs = UserProfile.where( user_id: cmts.pluck(:user_id) )
    cmts.map { |cmt| cmt.prof= profs.select{ |o| o.user_id==cmt.user_id }.first }
    cmts
  end

  # this method is executed when [like] button cliked
  def self.love( params )
    id, user_id = params[:id], params[:user_id]
    recipe = self.find(id)
    recipe.love_count += 1
    recipe.save

    RecipeLoveLog.create( recipe_id: id, user_id: user_id )
    recipe
  end

  def self.top_content
    top_content = ToppageContent.first
    top_content && Recipe.find_by_id(top_content.recommend_recipe_genre_id)
  end

  def self.list( params={}, order_mode=nil )
    wheres = []

    foods = self.parse_parameter_for_foods( params )
    wheres<< [" recipe_food_id IN (?) ", foods.pluck(:id) ] if foods.pluck(:id).present?

    if params[:word]
      word = params[:word].gsub( /^\s*/,'').gsub(/\s+$/,'')
      foodstuffs = RecipeFoodstuff.where( " name = ? ", "#{word}" ).select("distinct recipe_id").pluck(:recipe_id)
      wheres<< [ " id IN (?) ", foodstuffs ]
      wheres<< [" title like ? ", "%#{word}%" ]
    end

    # array pair data change to sql where segment
    wheres = [ wheres.map(&:first).join(" OR "), *wheres.map(&:second) ]

    recipes = Recipe.where( " public = true " )
    recipes = recipes.where( *wheres )
    recipes.order( (order_mode=="new") ? " created_at DESC " : " view_count DESC " )
  end

  def self.parse_parameter_for_foods( params )
    foods = RecipeFood.scoped
    if params[:recipe_food_id]
      foods = RecipeFood.where( id: params[:recipe_food_id] ) 
    elsif params[:recipe_food_genre_id]
      food_genre = RecipeFoodGenre.where( id: params[:recipe_food_genre_id] ).first
      foods = food_genre.foods
    elsif params[:recipe_food_name]
      # recipe_food_name parameter search recipe genre or recipe_foods
      genred_food_ids = RecipeFoodGenre.where( " name LIKE ? ", "%#{params[:recipe_food_name]}%" ).includes(:recipe_foods).map{ |o| o.recipe_foods.map(&:id) }.flatten
      foods = RecipeFood.where( " name LIKE ? OR recipe_food_genre_id IN (?) ", "%#{params[:recipe_food_name]}%", genred_food_ids )
    end
    foods
  end

  def self.food_genre_recommend_recipe(params)
    # current recommend recipe is newest recipe in search result
    self.list( params, "new" ).first
  end

  def view_count_increment!
    self.view_count+=1
    self.save
  end

  def create_draft( form_values )
    draft = RecipeDraft.new
    draft.attributes= form_values
    draft.recipe_id= self.id
    draft.user_id= self.user_id
    draft.save
    draft
  end

  # @param type
  def publication( type )
    recipe_food = RecipeFood.find( self.recipe_food_id )
    recipe_food_genre = RecipeFoodGenre.find(recipe_food.recipe_food_genre_id)

    if type
      self.public = true
      self.status = (self.status == 0) ? 1 : self.status
      recipe_food_genre.amount += 1
    else
      self.public = false
      recipe_food_genre.amount -= 1
    end

    ActiveRecord::Base.transaction do
      recipe_food_genre.save
      self.save
    end
    self
  end
end

