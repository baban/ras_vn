# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :omniuser do
    provider "MyString"
    uid "MyString"
    name "MyString"
  end
end
