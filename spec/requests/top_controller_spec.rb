# encoding: utf-8

require 'spec_helper'

describe TopController, :type => :request do
  describe "GET 'index'" do
    context "ログイン時" do
      it "returns http success" do
        visit '/user/sign_in'
        within("#new_user") do
          fill_in 'Login', :with => 'babanba.n@gmail.com'
          fill_in 'Password', :with => 'svc2027'
        end
        # TODO; usersテーブルのfixtureがないので無理じゃん
        # click_link 'Sign in'
      end
    end
    context "非ログイン時" do
    end
  end
end
