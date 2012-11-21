# encoding: utf-8

class RecipeCommentUploader < BaseUploader
  process resize_to_fit: [280,466]
  version :thumb do
    process resize_to_limit: [280, 466]  
  end
end

