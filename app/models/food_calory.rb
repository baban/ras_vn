# encoding: utf-8

class FoodCalory < ActiveRecord::Base
  def self.parse_amount( amount )
    if pair = amount.match(/([1-9]+)\/([1-9]+)/)
      origin, child, mother = pair.to_a
      return (child.to_f / mother.to_f)
    end
    amount.to_f
  end

  def self.parse_unit( amount )
    { "½" => "1/2" }.each { |k,v| amount.gsub!(k,v) }
    amount = amount.tr('０-９','0-9').tr('／','/')
    [ 
     /([0-9]+)(個)/,
     /\s*([0-9]+|[1-9]+\/[1-9]+)\s*(trai|cai|thìa cà phê|tai|lát|thìa|củ)\s*/,
     /\s*([0-9]+|[1-9]+\/[1-9]+)\s*(muỗng canh|quả|bát|gói|hộp|lá|chén|ít|trái|nhánh)\s*/,
     /\s*([0-9]+)\s*(g|gr|ml|kg)\s*/,
    ].each do |regexp|
      m = amount.match(regexp)
      next unless m
      origin, amount, unit = m.to_a
      amount = self.parse_amount( amount )
      return [origin,amount,unit]
    end
    nil
  end
end
