FactoryGirl.define do
  factory :pdf do
    association :user
    association :ticket
    file File.open(File.join(Rails.root, "spec", "support", "images", "nikujaga.pdf"))
  end
end
