# encoding: utf-8

class NewsfeedUploader < BaseUploader
  process resize_to_fit: [640,480]
  version :thumb do
    process resize_to_fill: [48,48]
  end
end
