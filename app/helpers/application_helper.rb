# encoding: utf-8

module ApplicationHelper
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
