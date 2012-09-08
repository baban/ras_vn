# encoding: utf-8

module FormHelper
  def distinct_selecter(f)
    tag  = f.select(:prefecture_id, options_for_select(Prefecture.all.map{ |o| [ o.name, o.id ] }) )
    tag += f.grouped_collection_select(:distinct_id, Prefecture.all, :distincts, :name, :id, :name )
    tag.html_safe
  end
end
