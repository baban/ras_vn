#encoding: utf-8

class Bookmark < ActiveRecord::Base
  belongs_to :recipes
  belongs_to :users

  # get all bookmarked shops
  def self.list
    Recipe.where('')
  end
end
