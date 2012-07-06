# encoding: utf-8

class Diary < ActiveRecord::Base
  belongs_to :user

  default_scope order:'id DESC'
  paginates_per 20

end
