# encoding: utf-8

class RecipeCommentUploader < BaseUploader
  version :thumb do
    process :resize_to_limit => [200, 200]  
  end
end

