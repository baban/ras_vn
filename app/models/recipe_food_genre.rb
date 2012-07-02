# encoding: utf-8

class RecipeFoodGenre < ActiveRecord::Base
  has_many :recipe_foods
  alias :foods :recipe_foods

  scope :topics, ->{ page(1).per(3) }
end
