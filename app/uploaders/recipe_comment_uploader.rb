# encoding: utf-8

class RecipeCommentUploader < BaseUploader
  version :thumb do
    process scale:[150, 150]
  end
end

