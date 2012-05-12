# encoding: utf-8

module ProfileHelper
  def select_sex( f, value=nil, options={} )
    f.select( :sex, { "選択する"=>nil, "男性"=>1, "女性"=>2," その他"=>0 }, {selected: 1}, options )
  end

  def translate_sex( sex )
    case sex
    when 1; "男性"
    when 2; "女性"
    when 3; "その他"
    else  ; "不明"
    end
  end
end
