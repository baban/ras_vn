# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :foodstuff, :class => 'Foodstuffs' do
    name "MyString"
    count "MyString"
  end
end
