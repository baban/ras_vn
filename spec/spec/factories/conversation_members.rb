# Read about factories at http://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :conversation_member do
    association :user
  end
end
