# encoding: utf-8

class EntretLog < ActiveRecord::Base
  attr_accessible :status, :user_id

  module Status
    ENTRY   = 1
    RETIRE  = 2
    REENTRY = 3
  end

  def self.entry( user_id )
    self.create( user_id: user_id, status: Status::ENTRY )
  rescue => e
    logger.info " entry user : #{user_id}"
  end

  def self.retire( user_id )
    self.create( user_id: user_id, status: Status::RETIRE )
  rescue => e
    logger.info " entry user : #{user_id}"
  end

  def self.reentry( user_id )
    self.create( user_id: user_id, status: Status::REENTRY )
  rescue => e
    logger.info " reentry user : #{user_id}"
  end

end
