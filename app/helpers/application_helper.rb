# encoding: utf-8

module ApplicationHelper
  def profile_image_tag(profile)
    if profile and profile.image
      image_tag(profile.image, alt: profile.nickname, size:"200x200")
    else
      image_tag("/assets/noimage.gif", alt: "no_image", size:"200x200")
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
