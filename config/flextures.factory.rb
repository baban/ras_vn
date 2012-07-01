# encoding: utf-8

Flextures::Factory.define :users do |f|
end

Flextures::Factory.define :restaurant_profiles do |f|
  #filename = Rails.root.to_path + "/app/assets/images/tp_m.jpg"
  #f.top_photo = IO.read("#{filename}")
end

Flextures::Factory.define :recipes do |f|
  #filename = Rails.root.to_path + "/app/assets/images/recipe_img.jpg"
  #f.image = IO.read("#{filename}")
  f
end

