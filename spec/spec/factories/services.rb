# Read about factories at http://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  sequence :uid do |n|
    "uid_#{n}"
  end

  factory :service do
    association :user
    uid { FactoryGirl.generate(:uid) }
  end

  factory :facebook_service, :parent => :service, :class => "Services::Facebook" do
    type "Services::Facebook"
  end

  factory :twitter_service, :parent => :service, :class => "Services::Twitter" do
    type "Services::Twitter"
    access_token "at"
    access_secret "as"
  end
end
