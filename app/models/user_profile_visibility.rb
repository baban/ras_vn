# encoding: utf-8

class UserProfileVisibility < ActiveRecord::Base
  # users table and user_profiles table are saved data to another database
  establish_connection "ras_vn_users" if [:staging,:production].include?(Rails.env.to_sym)

  belongs_to :user_profile
end
