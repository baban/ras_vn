#encoding: utf-8

class Bookmark < ActiveRecord::Base
  belongs_to :recipes
  belongs_to :users

  paginates_per 10

  # get all bookmarked shops
  def self.list
    Recipe.visibles
  end
end
