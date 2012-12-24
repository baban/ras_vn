# encoding: utf-8

class RecipeFoodstuffDraft < ActiveRecord::Base
  acts_as_paranoid

  belongs_to :recipe_draft

  def self.post_filter( form_values )
    foodstuffs = form_values.presence || []
    foodstuffs = foodstuffs.select{ |h| h[:name].present? and h[:amount].present? }.map{ |h| RecipeFoodstuffDraft.new(h) }
    foodstuffs = foodstuffs.map { |foodstuff| foodstuff.calc_calory }
    foodstuffs
  end

  def calc_calory
    origin, amount, unit = FoodCalory.parse_unit( self.amount )
    food_calory = FoodCalory.where( name: self.name, unit: unit ).first
    calory = nil
    calory = food_calory.calory * (amount.to_f / food_calory.amount.to_f) if food_calory
    self.calory ||= calory
    self
  end
end
