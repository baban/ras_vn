# encoding: utf-8

class UserProfile < ActiveRecord::Base
  has_one :user_profile_visibility
  alias :visibility :user_profile_visibility
  belongs_to :user
end
