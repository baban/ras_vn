# encoding: utf-8

class RecipeStep < ActiveRecord::Base
  acts_as_paranoid

  belongs_to :recipes
end
