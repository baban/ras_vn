# encoding: utf-8

class RecipeImageUploader < BaseUploader
  version :thumb do
    process resize_to_fill: [140,50], watermarking: []
  end
  version :large_thumb do
    process resize_to_fill: [400,400], watermarking: []
  end

  def watermarking
    manipulate! do |img|
      Rails.logger.info :manipulate
      img.combine_options do |c|
        c.gravity "SouthEast"
        c.draw 'image Over 0,0 0,0 "public/watermark.png"'
      end
      img
    end
  end
end
