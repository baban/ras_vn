# encoding: utf-8

class NewsfeedUploader < BaseUploader
  version :thumb do
    process resize_to_fill: [48,48]
  end
end
