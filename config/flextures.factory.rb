# encoding: utf-8

Flextures::Factory.define :users do |f|
  f
end

Flextures::Factory.define :restaurant_profiles do |f|
  filename = Rails.root.to_path + "/app/assets/images/tp_m.jpg"
  f.top_photo = IO.read("#{filename}")
end

