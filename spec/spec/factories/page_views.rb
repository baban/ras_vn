# Read about factories at http://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :page_view do
    association :ticket
    session_id "session"
  end

  factory :logined_page_view, :parent => :page_view do
    association :user
  end
end
