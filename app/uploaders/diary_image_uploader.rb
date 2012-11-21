# encoding: utf-8

class DiaryImageUploader < BaseUploader
  process resize_to_fit: [640,480]
end
