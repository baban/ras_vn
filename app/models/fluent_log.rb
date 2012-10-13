# encoding: utf-8

class FluentLog
  include Mongoid::Document  

  index path: 1

  field :code,    type: Integer
  field :host,    type: String
  field :path,    type: String
  field :size,    type: Integer
  field :referer, type: String
  field :agent,   type: String
  field :time,    type: DateTime

  def self.aggrigation
    # self.page_flow_aggrigation
    page_map = self.page_count_aggrigation
    move_log = MoveLog.aggrigate_log
    move_log = MoveLog.translate_aggrigated_log( move_log, page_map )

    ret = {
      nodes: page_map.map{ |k,v| { label: k, amount: v } }.sort{ |a,b| b[:amount] <=> b[:amount] },
      links: move_log
    }
    ret
  end

  def self.page_count_aggrigation
    # var map = "function () { emit(this.path, {}); }"
    # var reduce = "function (key, values) { return { amount: 1 }; }"
    # db.fluent_logs.mapReduce(map, reduce, {out: {inline:1}})

    map = "function () { emit(this.path, { path: this.path }); }"
    reduce = "function (key, values) { return { amount: values.length }; }"
    values = self.map_reduce(map, reduce).out(inline: true)
    values.select{ |row| row["_id"] }.inject({}){ |h,row| h[row["_id"]]=row["value"]["amount"].to_i; h }
  end

  def self.page_flow_aggrigation
    MoveLog.delete_all
    map = <<-MAP_FUNC
      function () {
        emit( this.host, { path: this.path, time: this.time } );
      }
    MAP_FUNC
    reduce = <<-REDUCE_FUNC
      function (key, values) {
        values.sort(function(a,b){ return (a.time==b.time) ? 0 : ((a.time>b.time)? 1 : -1); });
        var cache = values.shift();
        var moves = [];
        values.forEach(function(value){
          moves.push({ from: cache["path"], to: value["path"] });
          cache = value;
        });
        return { moves: moves };
      }
    REDUCE_FUNC

    values = self.map_reduce(map, reduce).out(inline: true)
    values = values.first["value"]["moves"]
    values.map { |log| MoveLog.create(log) }
  end
end
