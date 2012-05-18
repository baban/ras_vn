# encoding: utf-8

class Recipe < ActiveRecord::Base
  has_many :foodstuffs
  has_many :recipe_steps
  alias :steps :recipe_steps

  # this action generate steps for edit action
  def edit_steps
    # return value have at least 4 steps
    steps = recipe_steps.to_a
    (4 - steps.size).times{ steps<< RecipeStep.new } if steps.size < 4
    steps
  end

end
