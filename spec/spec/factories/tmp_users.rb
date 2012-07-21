# -*- coding: utf-8 -*-
# Read about factories at http://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :tmp_user do
    value({
      "provider" => "facebook",
      "uid" => "100001052805217",
      "info" => {
        "name" => "wakizaka",
        "nickname" => "tohae.wakizaka",
        "email" => "wakizaka@okwave.co.jp",
        "image" => "",
      },
      "credentials" => {
        "token" => "AAADqS0smsBYBADj7RfexuPIbArZBCRzIKs01ZBQtYLy0Avz6ZBXwIRHwvUL6mdDQaaWmAuqC08LIXaJ86xALE70J8KkQRDmfcTego51Lw29P4ZAo3ZA3B",
        "refresh_token" => "" 
      }
    })
  end

  factory :tmp_user_tw, :parent => :tmp_user do
    value({
      "provider" => "twitter",
      "uid" => "357916082",
      "info" => {
        "name" => "t_ooo",
        "nickname" => "t_ooo1",
        "email" => "t_kanehira@okwave.co.jp",
        "image" => "",
      },
      "credentials" => {
        "token" => "RzJlWn7neK6XCxR2P6XYg",
        "secret" => "um4Oih77pR2LdqaKIJpnXXOG73mhKUn378vOOTefYc" 
      }
    })
  end
end
