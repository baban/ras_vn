# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :recipe, :class => 'Recipes' do
    title "MyString"
    description "MyString"
  end
end
