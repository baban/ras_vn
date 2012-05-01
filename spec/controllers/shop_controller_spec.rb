# encoding: utf-8

require 'spec_helper'

describe ShopController do
  flextures :shops

  describe "GET 'show'" do
    it "returns http success" do
      get :index
      response.should be_success
    end
  end

  describe "GET 'show'" do
    it "returns http success" do
      get :show, id: 1
      response.should be_success
    end
  end

  describe "GET 'menu'" do
    it "returns http success" do
      get :menu, id: 1
      response.should be_success
    end
  end

  describe "GET 'map'" do
    it "returns http success" do
      get :map, id: 1
      response.should be_success
    end
  end

  describe "GET 'reserve'" do
    it "returns http success" do
      get :reserve
      response.should be_success
    end
  end

end
