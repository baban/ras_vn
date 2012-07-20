# encoding: utf-8
require 'spec_helper'

describe Api::ReviewsController do

  describe "GET index :format => json" do
    before do
      create(:review) 
      get :index, :format => "json"
      @json = JSON.parse(response.body)
    end
    it "status:200が返ること" do
      response.should be_success
    end

    it "jsonが返ること" do
      @json.should be_an_instance_of(Hash)
    end
  end

  describe "GET index :format => atom" do
    before do
      create(:review) 
      get :index, :format => "atom"
    end
    it "status:200が返ること" do
      response.should be_success
    end
  end
end
