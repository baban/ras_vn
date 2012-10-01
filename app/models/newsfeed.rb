# encoding: utf-8

class Newsfeed < ActiveRecord::Base
  mount_uploader :image, NewsfeedUploader

  scope :visibles, ->{ where( " public = ? ", true ).where( " start_dt IS NULL OR start_dt < ? ", Time.now ).where( " end_dt IS NULL OR end_dt > ? ", Time.now  ) }
  scope :topics, ->{ visibles.page(1).per(10) }
end
