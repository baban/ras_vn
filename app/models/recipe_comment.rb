# encoding: utf-8

class RecipeComment < ActiveRecord::Base
  acts_as_paranoid

  belongs_to :recipe

  validates :recipe_id, presence: true
  validates :user_id,   presence: true
  validates :title,     presence: true
  validates :content,   presence: true

  scope :visibles, ->{ scoped }
  scope :topics, ->{ visibles.page(1).per(3) }

  mount_uploader :image, RecipeCommentUploader

  def prof
    @cache || UserProfile.where( user_id: self.user_id ).first
  end
  alias :chef :prof

  def prof=(v)
    @cache=v
  end
  alias :chef= :prof=
end
