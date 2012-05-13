# encoding: utf-8

class Recipe < ActiveRecord::Base
  has_many :recipe_steps
  alias :steps :recipe_steps
end
