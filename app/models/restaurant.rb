# encoding: utf-8

class Restaurant < ActiveRecord::Base
  acts_as_paranoid

  has_one :restaurant_profile
  alias :profile :restaurant_profile

  has_many :restaurant_menus
  alias :menus :restaurant_menus

end
