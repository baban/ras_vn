# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :diary do
    title "MyString"
    content "MyText"
    public false
    deleted_at "2012-07-05 21:13:00"
  end
end
