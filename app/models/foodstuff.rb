# encoding: utf-8

class Foodstuff < ActiveRecord::Base
  acts_as_paranoid

  belongs_to :recipes
end
