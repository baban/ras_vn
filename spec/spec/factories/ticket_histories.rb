# Read about factories at http://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :ticket_history do
    association :ticket
  end
end
