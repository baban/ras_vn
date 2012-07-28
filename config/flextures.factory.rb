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

Flextures::Factory.define :admin_users do |f|
  f.preferences = YAML.load( Base64.decode64(f.preferences) )
  f.password = f.crypted_password
  f
end

Flextures::DumpFilter.define :admin_users, {
  preferences:->(v){ Base64.encode64(v.to_yaml) }
}

Flextures::Factory.define :users do |f|
  tmp_pass = f.encrypted_password
  f.password = "hogehoge"
  f.encrypted_password = tmp_pass
  f
end

Flextures::Factory.define :diaries do |f|
  f.title   = f.title.force_encoding("UTF-8").encode("UTF-8")
  f.content = f.content.force_encoding("UTF-8").encode("UTF-8")
  f
end


