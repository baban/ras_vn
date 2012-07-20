# Read about factories at http://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :want do
    association :user
    association :request_message

  end
end
