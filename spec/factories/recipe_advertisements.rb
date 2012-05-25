# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :recipe_advertisement, :class => 'RecipeAdvertisements' do
    name "MyString"
  end
end
