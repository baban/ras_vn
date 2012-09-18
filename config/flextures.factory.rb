# encoding: utf-8

Flextures::Factory.define :users do |f|
  tmp = Base64.decode64(f.encrypted_password)
  f.password = "hogehoge"
  f.encrypted_password = tmp
  f.user_profile= nil
  f
end

Flextures::DumpFilter.define :users, {
  encrypted_password:->(v){ Base64.encode64(v) }
}

Flextures::Factory.define :restaurant_profiles do |f|
  #filename = Rails.root.to_path + "/app/assets/images/tp_m.jpg"
  #f.top_photo = IO.read("#{filename}")
end

Flextures::Factory.define :recipes do |f|
  #filename = Rails.root.to_path + "/app/assets/images/recipe_img.jpg"
  #f.image = IO.read("#{filename}")
  #p f
  f
end

Flextures::Factory.define :admin_users do |f|
  tmp1 = Base64.decode64( f.crypted_password )
  tmp2 = Base64.decode64( f.token )
  tmp3 = Base64.decode64( f.salt )
  p tmp3
  f.password = "hogehoge"

  f.salt = tmp3
  f.token = tmp2
  f.crypted_password = tmp1
  f.preferences = YAML.load( Base64.decode64(f.preferences) )
  p f
  p f.valid?
  p f.errors
  f
end

Flextures::DumpFilter.define :admin_users, {
  preferences:->(v){ Base64.encode64(v.to_yaml) },
  crypted_password:->(v){ Base64.encode64(v) },
  token:->(v){ Base64.encode64(v) },
  salt:->(v){ Base64.encode64(v) }
}

Flextures::Factory.define :diaries do |f|
  f.title   = f.title.force_encoding("UTF-8").encode("UTF-8")
  f.content = f.content.force_encoding("UTF-8").encode("UTF-8")
  f
end


