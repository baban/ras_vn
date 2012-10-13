# encoding: utf-8

class MoveLog
  include Mongoid::Document  

  field :from, type: String
  field :to,   type: String

  def self.aggrigation( page_map )
    log = self.aggrigate_log
    self.translate_aggrigated_log( log, page_map )
  end

  def self.translate_aggrigated_log( log, page_map )
    page_map_fliped={}
    page_map.each_with_index do |pair,i|
      k,v = pair
      page_map_fliped[k]=i
    end

    log.map { |l| { source: page_map_fliped[l[0]], target: page_map_fliped[l[1]], amount: l[2], weight: 0.5 } }
  end

  def self.aggrigate_log
    m = "function () { emit( this.from+' -> '+this.to, {} ); }"
    r = "function (key, values) { return { amount: values.length }; }"

    values = self.map_reduce(m, r).out(inline: true)
    values.map do |h| 
      from, to = h["_id"].to_s.split(" -> ")
      [ from, to, h["value"]["amount"].to_i+1 ]
    end.select{ |o| (o.last > 0) and (o[0]!=o[1]) and (o.first!="null") }
  end
end

