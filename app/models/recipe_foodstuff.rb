# encoding: utf-8

class RecipeFoodstuff < ActiveRecord::Base
  acts_as_paranoid

  belongs_to :recipes
end
