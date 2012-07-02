# encoding: utf-8

class RecipeFoodGenreUploader < BaseUploader
  version :thumb do
    process resize_to_fill: [70,70]
  end
end
