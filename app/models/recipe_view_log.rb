# encoding: utf-8

class RecipeViewLog < ActiveRecord::Base
  def self.add( recipe_id )
    self.create( recipe_id: recipe_id )
  rescue => e
    logger.info " #{self.class} add error  "
  end

  def self.ranking
    d = Time.now
    self.where( created_at: (d-1.month)..d ).group(:recipe_id).select(" count(id) as id, recipe_id ").order( "id DESC" ).page(1).per(10)
  end
end
