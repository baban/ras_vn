# encoding: utf-8

class RecipeComment < ActiveRecord::Base
  belongs_to :recipe
end
