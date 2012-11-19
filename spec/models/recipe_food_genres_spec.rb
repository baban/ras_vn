require 'spec_helper'

describe RecipeFoodGenre do
  fixtures :recipe_food_genres, :recipe_foods
  describe ".choice" do
    context "normal forme" do
      before do
        @food_genre = RecipeFoodGenre.choice({})
      end
      it "RecipeFoodGenre" do
        @food_genre.should be_instance_of RecipeFoodGenre
      end
      it "ID is first element" do
        @food_genre.id.should == 1
      end
    end
    context "recipe_food_genre_id parameter" do
      before do
        @food_genre = RecipeFoodGenre.choice( recipe_food_genre_id: 2 )
      end
      it "ID is same parameter" do
        @food_genre.id.should == 2
      end
    end
    context "recipe_food_id parameter" do
      before do
        @food_genre = RecipeFoodGenre.choice( recipe_food_id: 30 )
      end
      it "ID is same parameter" do
        @food_genre.id.should == 3
      end
    end
  end
end
