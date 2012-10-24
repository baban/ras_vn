# encoding: utf-8

require 'spec_helper'

describe RecipesController do
  include Devise::TestHelpers

  fixtures :users, :user_profiles, :user_profile_visibilities, :recipes

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
    context "非ログイン時" do
      before do
        get :new
      end
      it "returns http success" do
        response.should be_redirect
      end
    end
    context "ログイン時" do
      login_admin
      before do
        get :new
      end
      it "returns http success" do
        response.should be_success
      end
    end
  end

  describe "GET 'edit'" do
    context "非ログイン時" do
      before do
        get :edit, id: 1
      end
      it "returns http success" do
        response.should be_redirect
      end
    end
    context "ログイン時" do
    end
  end


=begin

  describe "GET 'create'" do
    it "returns http success" do
      get 'create'
      response.should be_success
    end
  end

  describe "GET 'destroy'" do
    it "returns http success" do
      get 'destroy'
      response.should be_success
    end
  end

=end
end
