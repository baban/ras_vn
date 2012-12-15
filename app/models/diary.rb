# encoding: utf-8

class Diary < ActiveRecord::Base
  belongs_to :user

  validates :title,   presence: true
  validates :content, presence: true

  default_scope order:'id DESC'
  paginates_per 20

  mount_uploader :image, DiaryImageUploader
end

