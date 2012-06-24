# encoding: utf-8

class RecipeFoodstuffRanking < ActiveRecord::Base

  def self.topics
    ids = where("").page(1).per(3).all.map(&:recipe_foodstuff_id)
    RecipeFoodstuff.where( "id in (?) ", ids )
  end
end
