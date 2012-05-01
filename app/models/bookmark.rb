#encoding: utf-8

class Bookmark < ActiveRecord::Base
  # get all bookmarked shops
  def self.list
    Shop.where('')
  end
end
