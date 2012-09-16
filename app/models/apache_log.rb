# encoding: utf-8

class ApacheLog
  include Mongoid::Document 
  # db.test.group({ key:{ path: true }, cond:{ }, reduce: function(obj,prev){ prev.sum += 1; }, initial: { sum: 0 } })
  field :host
  def full_name  
    "#{host}"  
  end  
end
