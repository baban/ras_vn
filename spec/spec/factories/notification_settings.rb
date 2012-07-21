# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :notification_setting do
    body :favorite => "0"
  end
end
