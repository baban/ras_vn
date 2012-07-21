# -*- coding: utf-8 -*-
# Read about factories at http://github.com/thoughtbot/factory_girl

include ActionDispatch::TestProcess
FactoryGirl.define do

  sequence :url_name do |n|
    "wakizaka_#{n}"
  end

  sequence :email do |n|
    "wakizaka_#{n}@okwave.co.jp"
  end

  factory :user do
    name "wakizaka"
    url_name { FactoryGirl.generate(:url_name) }
    email { FactoryGirl.generate(:email) }
    description "OKWaveでエンジニアやってます"
    image { fixture_file_upload(Rails.root.to_s + "/spec/support/images/nikujaga.jpg", "image/jpg") }
    password "hogehoge"
    notifications_count 0
    sex 1
    verify_email_flag 1
    refuse_request_flag 0

    after_create do |user, proxy|
      FactoryGirl.create(:facebook_service, :user => user)
      proxy.image.close
    end

    trait :admin do
      admin_type 1
    end
    trait :user_communication do
      admin_type 2
    end
    trait :financial_affairs do
      admin_type 3
    end

    trait :developer do
      admin_type 4
    end

    trait :exhibited do
      exhibitor_flag 1
      after_create do |user|
        FactoryGirl.create(:unregistered_bank_exhibitor, :user => user)
      end
    end

    trait :invalid_email do
      email "wakizaka_okwave.co.jp"
    end

    trait :notificated do
      notifications_count 5
    end

    trait :unverified do
      verify_email_flag 0
    end

    trait :semi_vip do
      premium_status 1
    end
    trait :vip do
      premium_status 2
    end

    trait :deleted do
      delete_flag 1
    end

    trait :twitter do
      after_create do |user, proxy|
        FactoryGirl.create(:twitter_service, :user => user)
        proxy.image.close
      end
    end

    trait :refuse_board do
      refuse_board_flag true
    end

    trait :born_in_now do
      birthday Time.now
    end

    trait :notification_setting do
      after_create do |user|
        FactoryGirl.create(:notification_setting, :user_id => user.id)
      end
    end

    factory :admin_user, :traits => [:admin]
    factory :unverified_email_user, :traits => [:unverified]
    factory :user_communication_user, :traits => [:user_communication]
    factory :financial_affairs_user, :traits => [:financial_affairs]
    factory :develop_user, :traits => [:developer]
    factory :exhibited_user, :traits => [:exhibited]
    factory :invalid_email_user, :traits => [:invalid_email]
    factory :notificated_user, :traits => [:notificated]
    factory :semi_vip_user, :traits => [:semi_vip]
    factory :vip_user, :traits => [:vip]
    factory :deleted_user, :traits => [:deleted]
    factory :twitter_user, :traits => [:twitter]
    factory :refuse_board_user, :traits => [:refuse_board]
    factory :born_in_now_user, :traits => [:born_in_now]
    factory :notification_setting_user, :traits => [:notification_setting]
  end
  
  #factory :admin_user, :parent => :user do
  #  admin_type 1
  #end

  #factory :invalid_email_user, :parent => :user do
  #  email "wakizaka_okwave.co.jp"
  #end

  #factory :exhibited_user, :parent => :user do
  #  exhibitor_flag 1
  #end
end
