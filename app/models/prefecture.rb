# encoding: utf-8

class Prefecture < ActiveRecord::Base
  has_many :distincts
end
