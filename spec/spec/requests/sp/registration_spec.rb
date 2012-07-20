# encoding: utf-8
require 'spec_helper'

describe "SP/Registrations" do
  before do
    Capybara.current_driver = :sp
  end

  describe "ユーザー登録" do
    let(:user) { build(:user) }

    it "独自会員登録ができること" do
      visit sp_signin_path 
      click_link "会員登録する"
      page.should have_content("会員登録")
      fill_in "user_url_name", :with => user.url_name
      fill_in "user_email", :with => user.email
      fill_in "user_password", :with => user.password
      fill_in "user_password_confirmation", :with => user.password
      choose "女"
      check "user_accept"
      click_button "確認する"
      page.should have_content "入力内容を確認してください"
      page.should have_content user.url_name
      page.should have_content user.email
      page.should have_content "女"
      click_button("登録する")
      page.should have_content "会員登録が完了しました。"
    end
  end
end
