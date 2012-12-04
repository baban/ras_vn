# encoding: utf-8

require 'spec_helper'

describe BookmarksController do

  describe "GET 'index'" do
    it "returns http success" do
      get 'index'
      response.should be_success
    end
  end

  describe "GET 'create'" do
    it "returns http success" do
      get 'create'
      response.should be_success
    end
  end

  describe "GET 'deatroy'" do
    it "returns http success" do
      get 'deatroy'
      response.should be_success
    end
  end

end
