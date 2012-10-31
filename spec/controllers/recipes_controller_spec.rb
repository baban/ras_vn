# encoding: utf-8

require 'spec_helper'

describe RecipesController do
  fixtures :users, :user_profiles, :user_profile_visibilities, :recipes

  context "非ログイン時" do
    describe "GET 'index'" do
      before do
        get :index
      end
      it "returns http success" do
        response.should be_success
      end
    end

    describe "GET 'show'" do
      before do
        get :show, id: 2
      end
      it "returns http success" do
        response.should be_success
      end
    end

    describe "GET 'new'" do
      before do
        get :new
      end
      it "returns http success" do
        response.should be_redirect
      end
    end

    describe "GET 'edit'" do
      before do
        get :edit, id: 2
      end
      it "returns http success" do
        response.should be_redirect
      end
    end
  end

  context "ログイン時" do
    include Devise::TestHelpers
=begin
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
    describe "GET 'show'" do
      before do
        get :show, id: 2
      end
      it "returns http success" do
        response.should be_success
      end
    end

    describe "GET 'new'" do
      before do
        get :new
      end
      it "returns http success" do
        response.should be_success
      end
    end
=end
  end
end
