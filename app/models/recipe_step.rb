# encoding: utf-8

class RecipeStep < ActiveRecord::Base
  belongs_to :recipes
end
