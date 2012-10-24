# encoding: utf-8

require 'spec_helper'

feature "作成" do
  flextures :users, :user_profiles, :user_profile_visibilities

  describe "GET 'index'" do
    context "ログイン時" do

      scenario "returns http success" do
        visit '/user/sign_in'
        page.fill_in "user_email", with:"babanba.n@gmail.com"
        page.fill_in "user_password", with:"svc2027"
        
        click_button "sign_in"
        current_path.should == '/top/index'
      end
    end
  end
end
