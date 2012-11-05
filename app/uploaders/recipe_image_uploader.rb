# encoding: utf-8

class RecipeImageUploader < BaseUploader
  version :thumb do
    process resize_to_fill: [140,50], watermarking: []
  end
  version :large_thumb do
    process resize_to_fill: [400,400], watermarking: []
  end
  version :top_thumb do
    process resize_to_fill: [75,105], watermarking: []
  end
  version :top_large_thumb do
    process resize_to_fill: [170,250], watermarking: []
  end
  version :detail_large_thumb do
    process resize_to_fill: [280,466], big_watermarking: []
  end
  version :step_thumb do
    process resize_to_fill: [136,136], big_watermarking: []
  end

  def big_watermarking
    manipulate! do |img|
      Rails.logger.info :manipulate
      img.combine_options do |c|
        c.gravity "Center"
        c.draw 'image Over 0,0 0,0 "public/large_watermark.png"'
      end
      img
    end
  end

  def watermarking
    manipulate! do |img|
      Rails.logger.info :manipulate
      img.combine_options do |c|
        c.gravity "Center"
        c.draw 'image Over 0,0 0,0 "public/watermark.png"'
      end
      img
    end
  end
end
