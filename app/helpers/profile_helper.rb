# encoding: utf-8

module ProfileHelper
  def select_sex( f, value=nil, options={} )
    f.select( :sex, { "----"=>nil, "male"=>1, "female"=>2, "other"=>0 }, {selected: 1}, options )
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
