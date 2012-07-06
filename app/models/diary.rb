# encoding: utf-8

class Diary < ActiveRecord::Base
  belongs_to :user
end
