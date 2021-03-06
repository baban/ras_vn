# encoding: utf-8

require 'spec_helper'

describe TopController do
  fixtures :all
  context "非ログイン時" do
    describe "GET 'index'" do
      before do
        get :index
      end 
      it "returns http success" do
        response.should be_success
      end
    end
  end

  context "ログイン時" do
    include Devise::TestHelpers
    before do
      @user = User.first
      sign_in @user
    end 

    describe "GET 'index'" do
      before do
        get :index
      end 
      it "returns http success" do
        response.should be_success
      end
    end
  end
end
