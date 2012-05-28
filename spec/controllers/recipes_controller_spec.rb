# encoding: utf-8

require 'spec_helper'

describe RecipesController do
  fixtures :users, :user_profiles, :recipes

  describe "GET 'index'" do
    it "returns http success" do
      get :index
      response.should be_success
    end
  end

  describe "GET 'show'" do
    it "returns http success" do
      get :show, id: 2
      response.should be_success
    end
  end

  describe "GET 'new'" do
    context "非ログイン時" do
      it "returns http success" do
        get :new
        response.should be_redirect
      end
    end
    context "ログイン時" do
      it "returns http success" do
        #get :new
        #response.should be_success
      end
    end
  end


  describe "GET 'edit'" do
    context "非ログイン時" do
      it "returns http success" do
        get :edit, id: 1
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
