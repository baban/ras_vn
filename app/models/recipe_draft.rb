# encoding: utf-8

class RecipeDraft < ActiveRecord::Base
  acts_as_paranoid

  paginates_per 12

  has_many :recipe_foodstuff_drafts
  has_many :recipe_step_drafts
  belongs_to :user
  belongs_to :recipe

  validates :title,        presence: true
  validates :recipe_image, presence: true

  mount_uploader :recipe_image, RecipeImageUploader

  alias :foodstuffs  :recipe_foodstuff_drafts
  alias :foodstuffs= :recipe_foodstuff_drafts=
  alias :steps  :recipe_step_drafts
  alias :steps= :recipe_step_drafts=
  alias :image  :recipe_image
  alias :image= :recipe_image=

  def user
    User.find(self.user_id)
  end
  alias :chef :user

  def post_food_id( form_values )
    if form_values[:new_food_genre].present?
      self.recipe_food_id= RecipeFood.create( recipe_food_genre_id: form_values[:recipe_genre_selecter], name: form_values[:new_food_genre] ).id 
    else
      self.recipe_food_id = form_values[:recipe][:recipe_food_id] if form_values[:recipe][:recipe_food_id]
    end
    self
  end

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
    recipe = Recipe.find(self.recipe_id)

    attributes = self.attributes
    attributes.delete("recipe_id")
    recipe.attributes = attributes
    # file data is cannot copy so recipe_image colum data is insert
    recipe.recipe_image = File.open(self.recipe_image.current_path) if self.recipe_image.present?

    recipe.steps= self.steps.map.with_index do |d,i|
      attributes = d.attributes
      attributes["recipe_id"] = attributes["recipe_draft_id"]
      attributes.delete("recipe_draft_id")
      step = RecipeStep.new(attributes)
      step.image= File.open(d.image.current_path) if d.image.present?
      step
    end

    recipe.foodstuffs= self.foodstuffs.map do |d|
      attributes = d.attributes
      attributes["recipe_id"] = attributes["recipe_draft_id"]
      attributes.delete("recipe_draft_id")
      RecipeFoodstuff.new(attributes)
    end

    recipe.save( validate: false )
  end
end
