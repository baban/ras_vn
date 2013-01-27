# encoding: utf-8

class TrackerResult < ActiveRecord::Base
  attr_accessible :come, :day, :entry

  validates :day, presence: true

  def self.tracker_codes( d = Date.today )
    self.where( created_at: d.beginning_of_day..d.end_of_day ).group(:tracker_code).pluck(:tracker_code)
  end

  def self.aggrigation( day = Date.today )
    tracker_codes = TrackerLog.tracker_codes( day )

    y = day.yesterday
    yrow = self.where( day: y ).first

    tracker_codes.map do |code|
      row = self.find_or_create_by_day_and_tracker_code( day, code )
      day.to_datetime.instance_eval do |d|
        tl = TrackerLog.where( tracker_code: code ).where( created_at: d.beginning_of_day..d.end_of_day )
        row.come  = tl.count 
        row.entry = tl.where( " completed_at IS NOT NULL " ).count
      end
      row.save
      row
    end
  end
end
