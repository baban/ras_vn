# encoding: utf-8

class Newsfeed < ActiveRecord::Base
  mount_uploader :image, NewsfeedUploader

  scope :visibles, ->{ where( " public = ? ", true ).where( " start_at IS NULL OR start_at < ? ", Time.now ).where( " end_at IS NULL OR end_at > ? ", Time.now  ) }
  scope :topics, ->{ visibles.page(1).per(4) }
end
