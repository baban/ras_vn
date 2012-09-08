# encoding: utf-8

class Distinct < ActiveRecord::Base
  establish_connection "ras_vn_users" if [:staging,:production].include?(Rails.env.to_sym)

  belongs_to :prefecture

  has_many :distinct_food_genres
  alias :food_genres :distinct_food_genres

  scope :visibles, ->{ where( " public = ? ", true ) }
end
