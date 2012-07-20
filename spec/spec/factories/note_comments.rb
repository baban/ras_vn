# Read about factories at http://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :note_comment do
    association :user
    association :note
    body "MyString"
  end
end
