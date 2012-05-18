# encoding: utf-8

class UserProfile < ActiveRecord::Base
  belongs_to :user
end
