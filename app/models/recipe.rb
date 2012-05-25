# encoding: utf-8

class Recipe < ActiveRecord::Base
  acts_as_paranoid

  belongs_to :recipe_ranking

  has_many :recipe_foodstuffs
  has_many :recipe_steps

  alias :foodstuffs :recipe_foodstuffs
  alias :steps :recipe_steps

  # this action generate steps for edit action
  def edit_steps
    # return value have at least 4 steps
    steps = recipe_steps.to_a
    (4 - steps.size).times{ steps<< RecipeStep.new } if steps.size < 4
    steps
  end

end
