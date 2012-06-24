# encoding: utf-8

class RecipeStepsUploader < BaseUploader
  # process resize_to_fill: [200, 200]
  version :thumb do
    process resize_to_fill: [180,180]
  end
end
