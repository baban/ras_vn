# encoding: utf-8

class Recipe < ActiveRecord::Base
  acts_as_paranoid
  paginates_per 12

  has_one  :recipe_draft
  has_many :bookmarks
  has_many :recipe_foodstuffs
  has_many :recipe_steps
  has_many :recipe_comments

  belongs_to :recipe_ranking
  belongs_to :user

  accepts_nested_attributes_for :recipe_steps # use formastic plug-in

  mount_uploader :recipe_image, RecipeImageUploader 

  alias :draft :recipe_draft
  alias :foodstuffs :recipe_foodstuffs
  alias :steps :recipe_steps
  alias :comments :recipe_comments
  alias :image :recipe_image

  scope :visibles, ->{ where(" public = true ") }
  scope :topics, -> { visibles.page(1).per(2) }

  def user
    User.find(self.user_id)
  end
  alias :chef :user

  def view_count_increment!
    self.view_count+=1
    self.save
  end

  # this method generate foodstuffs for edit action
  def edit_foodstuffs
    foodstuffs = recipe_foodstuffs.to_a
    (4 - foodstuffs.size).times{ foodstuffs<< RecipeFoodstuff.new } if foodstuffs.size < 4
    foodstuffs
  end

  def food_genre
    RecipeFoodGenre.find_by_id(self.recipe_food_genre_id)
  end

  # this method is executed when [like] button cliked
  def self.like( params )
    id, user_id = params[:id], params[:user_id]
    recipe = self.find(id)
    recipe.like_count += 1
    recipe.save

    RecipeLikeLog.create( recipe_id: id, user_id: user_id )
  end
end

