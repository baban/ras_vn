# encoding: utf-8
require 'spec_helper'

describe "Login" do
  describe "GET /signin" do

    context "ID、パスワードが正しい場合" do
      before { @user = FactoryGirl.create(:user) }
      it "ログインできること", :js => true do
        visit signin_path
        
        # コメントを記載
        fill_in "user_url_name", :with => @user.url_name 
        fill_in "user_password", :with => @user.password 
        click_button "ログイン"

        current_path.should == root_path
        page.should have_content("マイページ") 
        
      end
    end

    context "ID、パスワードが正しくない場合" do
      before { @user = FactoryGirl.create(:user) }
      it "ログインできないこと", :js => true do
        visit signin_path
        
        # コメントを記載
        fill_in "user_url_name", :with => @user.url_name 
        fill_in "user_password", :with => "tigau" 
        click_button "ログイン"

        current_path.should == signin_path
        page.should have_content("アビリエIDまたはパスワードが違います") 
      end
    end
  end
end
