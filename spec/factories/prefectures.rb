# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :prefecture, :class => 'Prefectures' do
    name "MyString"
  end
end
