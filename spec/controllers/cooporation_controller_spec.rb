require 'spec_helper'

describe CooporationController do

  describe "GET 'profile'" do
    it "returns http success" do
      get 'profile'
      response.should be_success
    end
  end

  describe "GET 'terms'" do
    it "returns http success" do
      get 'terms'
      response.should be_success
    end
  end

  describe "GET 'question_and_answers'" do
    it "returns http success" do
      get 'question_and_answers'
      response.should be_success
    end
  end

end
