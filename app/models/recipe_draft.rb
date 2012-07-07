# encoding: utf-8

class RecipeDraft < ActiveRecord::Base
  acts_as_paranoid
  paginates_per 12

  has_many :recipe_foodstuff_drafts
  has_many :recipe_step_drafts
  belongs_to :user
  belongs_to :recipe

  mount_uploader :recipe_image, RecipeImageUploader

  alias :foodstuffs :recipe_foodstuff_drafts
  alias :steps :recipe_step_drafts
  alias :image :recipe_image

  def initialize(*_)
    super
    @recipe = self.recipe || Recipe.new(*_)
  end

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
end
