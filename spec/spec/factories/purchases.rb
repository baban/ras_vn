# Read about factories at http://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :purchase do
    association :user
    association :ticket

    cost 1000
    transaction_id "123"
    commit_request_at Time.now
  end
end
