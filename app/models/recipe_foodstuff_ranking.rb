# encoding: utf-8

class RecipeFoodstuffRanking < ActiveRecord::Base

  def self.topics
    RecipeFoodGenre.topics
  end
end
