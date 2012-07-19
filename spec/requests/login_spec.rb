# encoding: utf-8

require 'spec_helper'

feature "login process" do
  flextures :users
  describe "GET 'index'" do
    context "ログイン時" do
      scenario "returns http success" do
        session = Capybara::Session.new(:selenium)
        session.visit '/user/sign_in'
        # リダイレクトでTOPに戻る
        current_url.should == "/"
      end
    end

    context "非ログイン時" do
      scenario "returns http success" do
        visit '/user/sign_in'
        within("#new_user") do
          fill_in 'user[email]', :with => 'babanba.n@gmail.com'
          fill_in 'user[password]', :with => 'svc2027'
        end
        click_button 'Sign in'
      end
    end
  end
end
