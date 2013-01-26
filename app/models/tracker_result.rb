# encoding: utf-8

class TrackerResult < ActiveRecord::Base
  attr_accessible :come, :day, :entry

  validates :day, presence: true

  def self.aggrigation( day = Date.yesterday )
    y = day.yesterday
    yrow = self.where( day: y ).first

    row = self.find_or_create_by_day( day )
    row.day   = day
    row.come  = day.to_datetime.instance_eval { |d| TrackerLog.where( created_at: d.beginning_of_day..d.end_of_day ).count }
    row.entry = day.to_datetime.instance_eval { |d| TrackerLog.where( created_at: d.beginning_of_day..d.end_of_day ).where( " completed_at IS NOT NULL " ).count }
    row.save
    row
  end
end
