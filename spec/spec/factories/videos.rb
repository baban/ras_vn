# Read about factories at http://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :video do
    association :user
    association :ticket
    association :video_attachment
    title "title"
    description "description"
  end
end
