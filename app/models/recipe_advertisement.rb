# encoding: utf-8

class RecipeAdvertisement < ActiveRecord::Base
  mount_uploader :image, RecipeAdvertisementUploader 

  # select view advertisement
  def self.choice( user=nil, params={} )
    self.all.sample(1).first
  end
end
