# encoding: utf-8

class Distinct < ActiveRecord::Base
  belongs_to :prefecture

  class << self
    @@table = { size: nil } # テーブルのスタティックな情報を初期化時に保存しておく
    alias :old_count :count
    def count
      @@table[:size] || @@table[:size] = old_count
    end
  end


end
