# encoding: utf-8

require 'spec_helper'

feature "login process" do
  flextures :users
  describe "GET 'index'" do
    context "ユーザー登録" do
      scenario "returns http success" do
        visit '/user/sign_up'
        fill_in "user_email", with:"hoge@mage.jp"
        fill_in "user_password", with:"hogehoge"
        fill_in "user_password_confirmation", with:"hogehoge"
        fill_in "user_user_profile_attributes_nickname", with:"hogehoge"
        click_on "sign_in_button"

        current_path.should == "/"
      end
    end
  end
end
