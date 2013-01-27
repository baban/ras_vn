# endocindg: utf-8

class SearchLog < ActiveRecord::Base
  def self.add( word )
    self.create( words: word )
  rescue => e
    Rails.logger.info " serch log insert failed "
  end
end
