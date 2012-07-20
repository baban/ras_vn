# encoding: utf-8
# Read about factories at http://github.com/thoughtbot/factory_girl

include ActionDispatch::TestProcess
FactoryGirl.define do
  factory :exhibitor do
    association :user
    name "脇阪"
    zip_code "1111111"
    address "東京都"
    license_image_file { fixture_file_upload(Rails.root.to_s + "/spec/support/images/nikujaga.jpg", "image/jpg") }
    tel "09000000000"
    bank_name "ほげ銀行"
    bank_branch_name "ほげ銀行支店"
    bank_account_type "普通口座"
    bank_account_number "0123456"
    bank_account_kana "わきざかさん"
    judgment_status "0"
  end

  factory :unregistered_bank_exhibitor, :parent => :exhibitor do
    bank_name ""
    bank_branch_name ""
    bank_account_type ""
    bank_account_number ""
    bank_account_kana ""
  end
end
