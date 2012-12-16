# encoding: utf-8

class DiaryImageUploader < BaseUploader
  SIZE = { width: 640, height: 480 }
  process resize_to_fit: SIZE.values, if: :overwide?

  def overwide?(picture)
    image = MiniMagick::Image.open(picture.path)
    (image[:width] > SIZE[:width]) or (image[:height] > SIZE[:height])
  end
end
