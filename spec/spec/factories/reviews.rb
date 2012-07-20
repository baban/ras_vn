# -*- coding: utf-8 -*-
# Read about factories at http://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :review do
    rating 1
    description "15文字以上のレビュー内容です。"
    association :user
    association :ticket

    trait :delete do
      delete_flag true
    end

    factory :delete_review, :traits => [:delete]
  end
end
