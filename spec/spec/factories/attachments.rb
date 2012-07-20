# encoding: utf-8
# Read about factories at http://github.com/thoughtbot/factory_girl

include ActionDispatch::TestProcess
FactoryGirl.define do
  factory :attachment do
    association :user
    association :ticket
    image { fixture_file_upload(Rails.root.to_s + "/spec/support/images/nikujaga.jpg", "image/jpg") }

    after_create do |attachment, proxy|
      proxy.image.close
    end
  end
end
