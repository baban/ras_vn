require 'spec_helper'

describe SearchController do

  describe "GET 'index'" do
    it "returns http success" do
      get 'index'
      response.should be_success
    end
  end

  describe "GET 'area'" do
    it "returns http success" do
      get 'area'
      response.should be_success
    end
  end

  describe "GET 'food_genre'" do
    it "returns http success" do
      get 'food_genre'
      response.should be_success
    end
  end

  describe "GET 'character'" do
    it "returns http success" do
      get 'character'
      response.should be_success
    end
  end

end
