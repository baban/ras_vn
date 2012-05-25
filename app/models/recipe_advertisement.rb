# encoding: utf-8

class RecipeAdvertisement < ActiveRecord::Base
  # select view advertisement
  def self.choice
    self.all.sample(1).first
  end
end
