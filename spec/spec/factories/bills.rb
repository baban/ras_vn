# Read about factories at http://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :bill do
    association :user
    year Time.now.year 
    month Time.now.month 
    cost 3000
  end

  factory :payment_bill, :parent => :bill do
    type "Bills::Payment" 
  end

  factory :income_bill, :parent => :bill do
    type "Bills::Income" 
  end
end
