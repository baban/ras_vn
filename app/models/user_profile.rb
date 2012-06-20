# encoding: utf-8

class UserProfile < ActiveRecord::Base
  has_one :user_profile_visibility
  alias :visibility :user_profile_visibility
  belongs_to :user
  accepts_nested_attributes_for :user

  def initialize(*args)
    super(*args)
    self.user_profile_visibility= UserProfileVisibility.new
  end
end

