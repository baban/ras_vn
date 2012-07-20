# encoding: utf-8
require 'spec_helper'

describe "Login" do
  describe "GET /sp/signin" do

    context "ID、パスワードが正しい場合" do
      before { @user = FactoryGirl.create(:user) }
      it "ログインできること", :js => true do
        Capybara.current_driver = :sp
        visit sp_signin_path

        # コメントを記載
        fill_in "user_url_name", :with => @user.url_name 
        fill_in "user_password", :with => @user.password 
        click_button "ログイン"

        current_path.should == sp_root_path
        page.should have_content("マイページ") 

      end
    end

    context "ID、パスワードが正しくない場合" do
      before { @user = FactoryGirl.create(:user) }
      it "ログインできないこと", :js => true do
        Capybara.current_driver = :sp
        visit sp_signin_path

        # コメントを記載
        fill_in "user_url_name", :with => @user.url_name 
        fill_in "user_password", :with => "tigau" 
        click_button "ログイン"

        page.should have_content("アビリエIDまたはパスワードが違います") 
        page.should have_selector("section.pt10")
      end
    end
  end
end
