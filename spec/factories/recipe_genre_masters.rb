# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :recipe_genre_master, :class => 'RecipeGenreMasters' do
    name "MyString"
  end
end
