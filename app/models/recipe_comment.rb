# encoding: utf-8

class RecipeComment < ActiveRecord::Base
  belongs_to :recipe

  scope :visibles, ->{ scoped }
  scope :topics, ->{ visibles.page(1).per(3) }

  mount_uploader :image, RecipeCommentUploader

  def profs
    UserProfile.where( user_id: self.user_id )
  end

  def prof
    @cache || UserProfile.where( user_id: self.user_id ).first
  end
  alias :chef :prof
end
