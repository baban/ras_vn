# encoding: utf-8

module ApplicationHelper
 def hbr(s)
    s = html_escape(s)
    s.gsub(/\r\n|\r|\n/, "<br />").html_safe
  end

  def profile_image_tag(profile)
    if profile and profile.image.url(:thumb).present?
      image_tag(profile.image.url(:thumb), alt: profile.nickname, size:"180x180")
    else
      image_tag("/assets/noimage.png", alt: "no_image", size:"180x180")
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
