# encoding: utf-8

class RecipeAdvertisement < ActiveRecord::Base
  # select view advertisement
  def self.select
    self.all.sample(1)
  end
end
