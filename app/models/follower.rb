# encoding: utf-8

class Follower < ActiveRecord::Base
  belongs_to :users
end
