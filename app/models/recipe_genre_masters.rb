# encoding: utf-8

class RecipeGenreMasters < ActiveRecord::Base
  scope :genre, ->{ where(" parent_id = 0 ") }
  scope :sub_genre, ->(parent_id){ where(" parent_id = ? ", parent_id ) }
end
