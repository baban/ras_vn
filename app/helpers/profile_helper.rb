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

  def visibility_radios( visibility, attr_name )
    btn1 = radio_button( "user_profile_visibility", attr_name, 1, checked: (visibility.send(attr_name) ?   "checked" : nil) )
    btn2 = radio_button( "user_profile_visibility", attr_name, 0, checked: (visibility.send(attr_name).! ? "checked" : nil) )
    "公開#{btn1}非公開#{btn2}".html_safe
  end
end
