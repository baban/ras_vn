require 'spec_helper'

describe RecipeSearchController do

  describe "GET 'recipe_genre'" do
    it "returns http success" do
      get 'recipe_genre'
      response.should be_success
    end
  end

end
