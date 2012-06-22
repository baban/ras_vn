# encoding: utf-8

class Recipe < ActiveRecord::Base
  acts_as_paranoid
  paginates_per 12

  has_many :bookmarks
  has_many :recipe_foodstuffs
  has_many :recipe_steps
  has_many :recipe_comments

  belongs_to :recipe_ranking
  belongs_to :users

  accepts_nested_attributes_for :recipe_steps # use formastic plug-in

  mount_uploader :recipe_image, RecipeImageUploader 

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

  # this method generate steps for edit action
  def edit_steps
    # return value have at least 4 steps
    steps = recipe_steps.to_a
    (4 - steps.size).times{ steps<< RecipeStep.new } if steps.size < 4
    steps
  end

  # this method generate foodstuffs for edit action
  def edit_foodstuffs
    foodstuffs = recipe_foodstuffs.to_a
    (4 - foodstuffs.size).times{ foodstuffs<< RecipeFoodstuff.new } if foodstuffs.size < 4
    foodstuffs
  end

end
