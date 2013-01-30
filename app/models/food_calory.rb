# encoding: utf-8

class FoodCalory < ActiveRecord::Base
  def self.parse_amount( amount )
    if pair = amount.match(/([1-9]+)\/([1-9]+)/)
      origin, child, mother = pair.to_a
      return (child.to_f / mother.to_f)
    end
    amount.to_f
  end

  def self.change_fraction( amount )
    { 
      "½" => "1/2",
      "⅓" => "1/3", "⅔" => "2/3",
      "¼" => "1/4", "¾" => "3/4",
      "⅕" => "1/5", "⅖" => "2/5", "⅗" => "3/5", "⅘" => "4/5",
      "⅙" => "1/6", "⅚" => "5/6",
      "⅛" => "1/8", "⅜" => "3/8", "⅝" => "5/8", "⅞" => "7/8",
    }.each { |k,v| amount.gsub!(k,v) }
    amount
  end

  def self.parse_unit( amount )
    amount = self.change_fraction( amount )
    amount = amount.tr('０-９','0-9').tr('／','/')
    [ 
     /([0-9]+)(個)/,
     /\s*([0-9]+|[1-9]+\/[1-9]+)\s*(trai|cai|thìa cà phê|tai|lát|thìa|củ)\s*/,
     /\s*([0-9]+|[1-9]+\/[1-9]+)\s*(muỗng canh|muỗng cà phê|muỗng|quả|bát|gói|hộp|lá|chén|ít|trái|nhánh)\s*/,
     /\s*([0-9]+|[1-9]+\/[1-9]+)\s*(miếng|tép|cái)\s*/,
     /\s*([0-9]+|[1-9]+\/[1-9]+)\s*(cup|g|gr|ml|kg)\s*/,
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
