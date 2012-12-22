# encoding: utf-8

class RecipeStep < ActiveRecord::Base
  acts_as_paranoid

  validates :recipe_id, presence: true
  validates :content,   length: { maximum: 800 }

  mount_uploader :image, RecipeStepsUploader
end
