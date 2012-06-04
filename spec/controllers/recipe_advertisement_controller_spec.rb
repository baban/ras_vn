require 'spec_helper'

describe RecipeAdvertisementController do

  describe "GET 'image'" do
    it "returns http success" do
      get 'image'
      response.should be_success
    end
  end

end
