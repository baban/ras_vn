# Read about factories at http://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  sequence :category_name do |n|
    "category_name_#{n}"
  end
  sequence :category_url_name do |n|
    "url_name_#{n}"
  end

  factory :category do
    name { FactoryGirl.generate(:category_name) }
    url_name { FactoryGirl.generate(:category_url_name) }
  end
end
