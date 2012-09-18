# encoding: utf-8

class FluentLog
  include Mongoid::Document

  field :host, type: String
  field :path, type: String
  field :user, type: String
  field :method, type: String
  field :code, type: Integer
  field :size, type: Integer
  field :referer, type: String
  field :agent, type: String
  field :time, type: DateTime

  # db.fluent_logs.group({ key: { path: true }, cond:{}, reduce: function(a,b){ b.sum++; }, initial:{ sum: 0 } })
end
