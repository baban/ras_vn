# encoding: utf-8

class Foodstuff < ActiveRecord::Base
  belongs_to :recipes
end
