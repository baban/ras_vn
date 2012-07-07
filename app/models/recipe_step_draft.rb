# encoding: utf-8

class RecipeStepDraft < ActiveRecord::Base
  acts_as_paranoid

  belongs_to :recipe_draft
end
