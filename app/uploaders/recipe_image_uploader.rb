# encoding: utf-8

class RecipeImageUploader < BaseUploader

  # process resize_to_fill: [200, 200]
  version :thumb do
    process( resize_to_fill: [140,50] ) do |img|
      
    end
  end
  version :large_thumb do
    process resize_to_fill: [400,400]
  end
end
