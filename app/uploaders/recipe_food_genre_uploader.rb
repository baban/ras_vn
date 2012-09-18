# encoding: utf-8

class RecipeFoodGenreUploader < BaseUploader
  version :thumb do
    process resize_to_fill: [60,60]
  end

  def extension_white_list
    %w(jpg)
  end

  def filename
    "food.jpg"
  end
end
