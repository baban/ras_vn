# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :recipe_step, :class => 'RecipeSteps' do
    context "MyString"
  end
end