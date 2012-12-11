# encoding: utf-8

module ApplicationHelper
 def hbr(s)
    s = html_escape(s)
    s.gsub(/\r\n|\r|\n/, "<br />").html_safe
  end

 def profile_image_tag(profile, type=:thumb, options={})
    size = { thumb:"180x180", small_icon:"22x22" }[type.to_sym] || ""
    options = { alt: profile.nickname, size: size }.merge(options)
    if profile and profile.image.url(type).present?
      image_tag(profile.image.url(type), options )
    else
      image_tag("/assets/noimage_#{type}.png", alt: "", size: size )
    end
  end

  def include_action_style_sheet
    content_for :style_after do
      stylesheet_link_tag "#{params[:controller]}/#{params[:action]}"
    end
  end

  def include_action_javascript
    content_for :javascript_after do
      javascript_include_tag "#{params[:controller]}/#{params[:action]}"
    end
  end
end
