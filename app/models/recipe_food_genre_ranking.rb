# encoding: utf-8

class RecipeFoodGenreRanking < ActiveRecord::Base
  def self.topics
    RecipeFoodGenre.topics
  end

  def self.aggrigation
    
  end
end
