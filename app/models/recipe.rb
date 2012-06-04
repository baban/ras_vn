# encoding: utf-8

class Recipe < ActiveRecord::Base
  acts_as_paranoid

  belongs_to :recipe_ranking

  has_many :recipe_foodstuffs
  has_many :recipe_steps
  has_many :recipe_comments

  accepts_nested_attributes_for :recipe_steps # use formastic plug-in

  mount_uploader :recipe_image, RecipeImageUploader 

  alias :foodstuffs :recipe_foodstuffs
  alias :steps :recipe_steps
  alias :comments :recipe_comments

  def user
    User.find(self.user_id)
  end

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
