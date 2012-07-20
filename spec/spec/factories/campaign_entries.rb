# encoding: utf-8
# Read about factories at http://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :campaign_entry do
    association :user
    association :campaign
    name "脇阪"
    zip_code "1111111"
    address "東京都"
  end

  factory :review_campaign_entry, :parent => :campaign_entry do
    answers ["aaaaaaaaaaaaaaa", "bbbbbbbbbbbbbbb", "ccccccccccccccc"]
  end
end
