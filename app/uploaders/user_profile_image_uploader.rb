# encoding: utf-8

class UserProfileImageUploader < BaseUploader
  version :thumb do
    process resize_to_limit: [180, 180]  
  end
  version :icon do
    process resize_to_limit: [32, 32]  
  end
end