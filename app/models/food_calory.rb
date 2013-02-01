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

  def self.number_amount_parse( amount )
    units = [
      "個","m cà-phê","tô","nửa củ","ống","thia","chiếc","cọng","trai","cai","thìa cà phê","tai","lát","thìa","củ","muỗng canh",
      "muỗng cà phê", "muỗng","quả","bát","gói","hộp","lá","chén","nhúm nhỏ","nhúm","lọn nhỏ","lóng","lon","ít","trái","nhánh",
      "miếng","tép","cái","cây","viên","bánh","cốc","thỏi","bó","con","bịch","lít","cup","gr","g","ml","kg"
    ].join("|")
    regexp = /\s*([0-9]+|[0-9]\.[0-9]|[1-9]+\/[1-9]+)\s*(#{units})\s*/
    m = amount.match(regexp)
    return unless m
    origin, amount2, unit = m.to_a
    amount3 = self.parse_amount( amount2 )
    [origin,amount3,unit]
  end

  def self.name_parse_unit( amount )
    units = [
     "thìa cà phê","Một chút", "Một ít", "Vừa ăn", "Vừa đủ", "một chút", "một miếng","một ít",
     "nửa củ", "nữa chén", "phan nguoi an", "tí xíu", "tùy khẩu vị", "tùy thích", "vua du",
     "vài nhánh", "vừa ăn", "vừa đủ"
    ]
    regexp = /\s*(#{units})\s*/
    m = amount.match(regexp)

    return unless m

    origin, unit = m.to_a
    [origin, 1, unit]
  end

  def self.parse_unit( amount )
    amount = self.change_fraction( amount )
    amount = amount.tr('０-９','0-9').tr('／','/')
    amount = amount.gsub(/([0-9]+),([0-9]+)/,"\\1.\\2")

    values = self.number_amount_parse( amount )

    return values if values

    values = self.name_parse_unit( amount )

    return values if values

    nil
  end
end
