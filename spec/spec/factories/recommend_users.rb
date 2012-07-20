# Read about factories at http://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :recommend_user do
    association :user
    score 100
  end
end
