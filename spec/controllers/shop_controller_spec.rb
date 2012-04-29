require 'spec_helper'

describe ShopController do

  describe "GET 'show'" do
    it "returns http success" do
      get 'show'
      response.should be_success
    end
  end

  describe "GET 'meny'" do
    it "returns http success" do
      get 'meny'
      response.should be_success
    end
  end

  describe "GET 'map'" do
    it "returns http success" do
      get 'map'
      response.should be_success
    end
  end

  describe "GET 'reserve'" do
    it "returns http success" do
      get 'reserve'
      response.should be_success
    end
  end

end
