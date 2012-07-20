# Read about factories at http://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :request_message do
    association :user

    to_user_id 0
    description "higehige"
    wants_count 0

    trait :wanted do
      wants_count 3
    end

    factory :wanted_request_message, :traits => [:wanted]
  end
end
