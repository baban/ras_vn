# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :search_log do
    association :user
    word "hogehoge"
    session_id "session_id"
  end
end
