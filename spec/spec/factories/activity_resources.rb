# Read about factories at http://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :activity_resource do
    association :activity
  end
end
