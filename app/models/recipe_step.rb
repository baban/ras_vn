# encoding: utf-8

class RecipeStep < ActiveRecord::Base
  acts_as_paranoid

  mount_uploader :image, RecipeStepsUploader
end
