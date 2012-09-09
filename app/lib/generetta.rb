# encoding: utf-8

require "find"

module Generetta
  ClassModel  = Struct.new(:classname,:methods)
  MethodModel = Struct.new(:name,:context)

  module Parser
    def self.find_files
      dir = "#{Rails.root.to_path}/app/models"
      
      # 読み込み可能なファイル一覧
      readable_models = []
      Find.find(dir) do |fpath|
        readable_models<< fpath if File.file?(fpath) and File::Stat.new(fpath).readable?
      end

      readable_models.map do |fpath|
        parse(fpath)
      end
    end

    def self.parse(fpath)
      models = {}
      
      content = File.load(fpath)
      # クラス名とメソッド名を配列で返す
      
    end
  end
end
