# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :toppage_content, :class => 'ToppageContents' do
    recomment_recipe_genre_id 1
  end
end
