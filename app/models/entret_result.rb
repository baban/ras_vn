# encoding: utf-8

class EntretResult < ActiveRecord::Base
  # called by batch
  def self.aggritate( day = Date.yesterday )
    y = day.yesterday
    yrow = self.where( day: y ).first

    row = self.find_or_create_by_day( day )
    row.day    = day
    row.entry  = day.to_datetime.instance_eval { |d| EntretLog.where( created_at: d.beginning_of_day..d.end_of_day ).where( status: [1,3] ).count }
    row.retire = day.to_datetime.instance_eval { |d| EntretLog.where( created_at: d.beginning_of_day..d.end_of_day ).where( status: 2 ).count }
    row.entret = row.entry - row.retire
    row.entry_total  = yrow.try(:entry_total).to_i  + row.entry
    row.retire_total = yrow.try(:retire_total).to_i + row.retire
    row.active_total = row.entry_total - row.retire_total
    row.save
    row
  end
end

