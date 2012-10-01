# encoding: utf-8

class Newsfeed < ActiveRecord::Base
  mount_uploader :image, NewsfeedUploader 
end
