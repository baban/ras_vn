# encoding: utf-8

class Recipe < ActiveRecord::Base
  acts_as_paranoid

  paginates_per 12

  ADD_RECIPE = 2

  validates :title, presence: true
  validates :image, presence: true

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

  scope :visibles, ->{ where( "public = true" ) }
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
    foods = RecipeFood.scoped
    if params[:recipe_food_id]
      foods = RecipeFood.where( id: params[:recipe_food_id] ) 
    elsif food_genre = RecipeFoodGenre.where( id: params[:recipe_food_genre_id] ).first
      foods = food_genre.foods
    end

    recipes = Recipe.scoped
    recipes = recipes.where( recipe_food_id: foods.pluck(:id) )       if foods.pluck(:id).present?
    recipes = recipes.where( " title like ? ", "%#{params[:word]}%" ) if params[:word]
    recipes.order( (order_mode=="new") ? " created_at DESC " : " view_count DESC " )
  end

  def include_user(recipes)
    profs = UserProfiles.where( recipes.pluck(:user_id) )
    recipes.map { |recipe| recipe.chef=profs.select{ |prof| prof.user_id==recipe.user_id }.first }
    recipes
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
end

