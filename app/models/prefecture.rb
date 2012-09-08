# encoding: utf-8

class Prefecture < ActiveRecord::Base
  establish_connection "ras_vn_users" if [:staging,:production].include?(Rails.env.to_sym)

  has_many :distincts

  scope :visibles, ->{ where( " public = ? ", true ) }
end
