# encoding: utf-8
require 'spec_helper'

describe "Registrations" do
  describe "ユーザー登録" do
    before(:all) do
      OmniAuth.config.test_mode = true
    end

    after(:all) do
      OmniAuth.config.test_mode = false
    end

    before do
      OmniAuth.config.mock_auth[:facebook] = FactoryGirl.build(:tmp_user).value
      @user = FactoryGirl.build(:user)
    end

    it "facebookアカウントでユーザー登録ができること" do
      visit signin_path
      click_link "facebook-login-button"
      page.should have_content("会員登録")
      attach_file "user_image", Rails.root.to_s + "/spec/support/images/nikujaga.jpg"
      fill_in "user_url_name", :with => @user.url_name
      fill_in "user_email", :with => @user.email
      fill_in "user_password", :with => @user.password
      fill_in "user_password_confirmation", :with => @user.password
      choose "男"
      check "user_accept"
      click_button("確認する")
      page.should have_content "入力内容を確認してください。"
      page.should have_content @user.url_name
      page.should have_content @user.email
      page.should have_content "男"
      click_button("登録する")
      page.should have_content "会員登録が完了しました。"
    end
  end
end
