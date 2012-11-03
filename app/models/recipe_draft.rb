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
  alias :foodstuffs= :recipe_foodstuff_drafts=
  alias :steps :recipe_step_drafts
  alias :steps= :recipe_step_drafts=
  alias :image :recipe_image

  def user
    User.find(self.user_id)
  end
  alias :chef :user

  # this method generate steps for edit action
  def edit_steps
    # return value have at least 4 steps
    steps = recipe_step_drafts.to_a
    (4 - steps.size).times{ steps<< RecipeStep.new } if steps.size < 4
    steps
  end

  # this method generate foodstuffs for edit action
  def edit_foodstuffs
    foodstuffs = recipe_foodstuff_drafts.to_a
    (4 - foodstuffs.size).times{ foodstuffs<< RecipeFoodstuff.new } if foodstuffs.size < 4
    foodstuffs
  end

  # recipe draft data copy to open
  def copy_public
    recipe = Recipe.find(self.id)

    attributes = self.attributes
    attributes.delete("recipe_id")
    recipe.attributes = attributes

    recipe.steps= self.steps.map do |d|
      attributes = d.attributes
      attributes["recipe_id"] = attributes["recipe_draft_id"]
      attributes.delete("recipe_draft_id")
      RecipeStep.new(attributes)
    end

    recipe.foodstuffs= self.foodstuffs.map do |d|
      attributes = d.attributes
      attributes["recipe_id"] = attributes["recipe_draft_id"]
      attributes.delete("recipe_draft_id")
      RecipeFoodstuff.new(attributes)
    end
    logger.info recipe.valid?
    logger.info recipe.errors.inspect
    recipe.save( validate: false )
  end
end
