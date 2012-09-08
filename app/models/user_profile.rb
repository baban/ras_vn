# encoding: utf-8

class UserProfile < ActiveRecord::Base
  # users table and user_profiles table are saved data to another database
  establish_connection "ras_vn_users" if [:staging,:production].include?(Rails.env.to_sym)

  has_one :user_profile_visibility
  alias :visibility :user_profile_visibility
  belongs_to :user
  accepts_nested_attributes_for :user

  validates :nickname,      presence: true
  validates :prefecture_id, presence: true
  validates :distinct_id,   presence: true

  mount_uploader :image, UserProfileImageUploader

  def initialize(*args)
    super(*args)
    self.user_profile_visibility= UserProfileVisibility.new
  end
end

