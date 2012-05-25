# encoding: utf-8

module RestaurantRecommend
  def self.list( option={} )
    # search by food
    if option[:recipe_food_genre_id]
      food_ids = RecipeFoodGenre.where( " id = ? ", option[:recipe_food_genre_id] ).foods.map(&:id)
    end
    Restaurant.all
  end
end
