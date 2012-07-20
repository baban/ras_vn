# Read about factories at http://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :message do
    association :user
    association :to_user, :factory => :user
    body "hogehoge"
  end

  factory :read_message, :parent => :message do
    read_flag true
  end
end
