# encoding: utf-8

module ProfileHelper
  def select_sex( f, value=nil, options={} )
    f.select( :sex, { "----"=>nil, "nam"=>1, "Nữ"=>2, "other"=>0 }, {selected: 1}, options )
  end

  def translate_sex( sex )
    case sex
    when 1; "nam"
    when 2; "Nữ"
    when 3; "other"
    else  ; "Unknown"
    end
  end

  def visibility_radios( visibility, attr_name )
    btn1 = radio_button( "user_profile_visibility", attr_name, 1, checked: (visibility.send(attr_name)   ? "checked" : nil) )
    btn2 = radio_button( "user_profile_visibility", attr_name, 0, checked: (visibility.send(attr_name).! ? "checked" : nil) )
    "#{t('status.public')}#{btn1}#{t('status.closed')}#{btn2}".html_safe
  end
end
