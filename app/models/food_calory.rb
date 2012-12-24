# encoding: utf-8

class FoodCalory < ActiveRecord::Base
  def self.parse_unit( amount )
    amount = amount.tr('０-９','0-9').tr('／','/')
    [ /([0-9]+)(g)/, /([0-9]+)(個)/ ].each do |regexp|
      m = amount.match(regexp)
      next unless m
      origin, amount, unit = m.to_a
      return [origin,amount.to_f,unit]
    end
    nil
  end
end
