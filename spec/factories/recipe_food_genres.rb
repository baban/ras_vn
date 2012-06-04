# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :recipe_food_genre, :class => 'RecipeFoodGenres' do
    name "MyString"
  end
end
