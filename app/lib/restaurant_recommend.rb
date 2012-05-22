# encoding: utf-8

module RestaurantRecommend
  def self.list( option={} )
    Restaurant.all
  end
end
