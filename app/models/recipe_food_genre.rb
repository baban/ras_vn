# encoding: utf-8

class RecipeFoodGenre < ActiveRecord::Base
  has_many :recipe_foods
  alias :foods :recipe_foods
  mount_uploader :image, RecipeFoodGenreUploader
  scope :topics, ->{ page(1).per(3) }

  scope :top_viewable_foods, ->{ foods.where( " show_top = ? ", true ) }
end
