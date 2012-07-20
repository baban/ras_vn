# Read about factories at http://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :tmp_purchase do
    association :ticket
    association :user
    transaction_id "1234"
  end
end
