# encoding: utf-8

class FluentLog
  include Mongoid::Document
  # db.fluent_logs.group({ key: { path: true }, cond:{}, reduce: function(a,b){ b.sum++; }, initial:{ sum: 0 } })
  
end
