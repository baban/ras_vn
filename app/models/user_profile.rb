# encoding: utf-8

class UserProfile < ActiveRecord::Base
  has_one :user_profile_visibility
  alias :visibility :user_profile_visibility
  belongs_to :user
  accepts_nested_attributes_for :user

  validates :nickname, presence: true
  validates :prefecture_id, inclusion: { in:(0..1000) }

  mount_uploader :image, UserProfileImageUploader

  def initialize(*args)
    super(*args)
    self.user_profile_visibility= UserProfileVisibility.new
  end
end

