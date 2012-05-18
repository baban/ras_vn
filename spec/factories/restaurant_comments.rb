# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :restaurant_comment do
    restaurant_id 1
    comment "MyString"
  end
end
