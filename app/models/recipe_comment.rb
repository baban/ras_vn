# encoding: utf-8

class RecipeComment < ActiveRecord::Base
  belongs_to :recipe

  scope :visibles, ->{ where("") }
  scope :topics, ->{ visibles.page(1).per(3) }

  mount_uploader :image, RecipeCommentUploader

  def prof
    UserProfile.find_by_user_id(self.user_id)
  end
  alias :chef :prof
end
