# encoding: utf-8

class RecipeFoodstuffDraft < ActiveRecord::Base
  acts_as_paranoid

  belongs_to :recipe_draft

  def self.post_filter( form_values )
    foodstuffs = form_values.presence || []
    foodstuffs = foodstuffs.select{ |h| h[:name].present? and h[:amount].present? }.map{ |h| RecipeFoodstuffDraft.new(h) }
    foodstuffs
  end
end
