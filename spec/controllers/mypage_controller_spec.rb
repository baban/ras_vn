# encoding: utf-8

require 'spec_helper'

describe MypageController do
  flextures :users, :user_profiles, :user_profile_visibilities

  describe "GET 'index'" do
    before  do
      get :index
    end
    it "returns http success" do
      response.should be_success
    end
  end

end
