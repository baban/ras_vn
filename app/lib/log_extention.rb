# encoding: utf-8

# ログ系のテーブルにaddメソッドを追加する
module LogExtention
  def add( *args )
    self.create( args.first ) if args.size==1 and args.first.is_a?(Hash)
  end
end
