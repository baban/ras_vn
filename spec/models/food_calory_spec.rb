# encoding: utf-8

require 'spec_helper'

describe FoodCalory do
  fixtures :food_calories
  describe "#calc_calory" do
    context "個数" do
      before do
        @origin, @amount, @unit = FoodCalory.parse_unit("1個")
      end
      it "個数が意図通りとれている" do
        @amount.should == 1
      end
      it "単位が意図通りとれている" do
        @unit.should == "個"
      end
    end
    context "全角個数" do
      before do
        @origin, @amount, @unit = FoodCalory.parse_unit("１０個")
      end
      it "個数が意図通りとれている" do
        @amount.should == 10
      end
      it "単位が意図通りとれている" do
        @unit.should == "個"
      end
    end
    context "グラム表示" do
      before do
        @origin, @amount, @unit = FoodCalory.parse_unit("200g")
      end
      it "個数が意図通りとれている" do
        @amount.should == 200
      end
      it "単位が意図通りとれている" do
        @unit.should == "g"
      end
    end
    context "グラム表示" do
      before do
        @origin, @amount, @unit = FoodCalory.parse_unit("ああああ")
      end
      it "個数が意図通りとれている" do
        @amount.should be_nil
      end
      it "単位が意図通りとれている" do
        @unit.should be_nil
      end
    end
    context "trai" do
      context "正常系" do
        before do
          @origin, @amount, @unit = FoodCalory.parse_unit("2 trai")
        end
        it "数値が意図通り" do
          @amount.should == 2.0
        end
        it "単位が意図通り" do
          @unit.should == "trai"
        end
      end
      context "スペースなし" do
        before do
          @origin, @amount, @unit = FoodCalory.parse_unit("2trai")
        end
        it "数値が意図通り" do
          @amount.should == 2.0
        end
        it "単位が意図通り" do
          @unit.should == "trai"
        end
      end
    end
    context "cai" do
      context "正常系" do
        before do
          @origin, @amount, @unit = FoodCalory.parse_unit("1 cai")
        end
        it "数値が意図通り" do
          @amount.should == 1.0
        end
        it "単位が意図通り" do
          @unit.should == "cai"
        end
      end
      context "スペース無し" do
        before do
          @origin, @amount, @unit = FoodCalory.parse_unit("1cai")
        end
        it "数値が意図通り" do
          @amount.should == 1.0
        end
        it "単位が意図通り" do
          @unit.should == "cai"
        end
      end
    end
    context "tai" do
      context "正常系" do
        before do
          @origin, @amount, @unit = FoodCalory.parse_unit("4 tai")
        end
        it "数値が意図通り" do
          @amount.should == 4.0
        end
        it "単位が意図通り" do
          @unit.should == "tai"
        end
      end
      context "スペース無し" do
        before do
          @origin, @amount, @unit = FoodCalory.parse_unit("4tai")
        end
        it "数値が意図通り" do
          @amount.should == 4.0
        end
        it "単位が意図通り" do
          @unit.should == "tai"
        end
      end
    end
    context "thìa cà phê" do
      context "正常系" do
        before do
          @origin, @amount, @unit = FoodCalory.parse_unit("1 thìa cà phê")
        end
        it "数値が意図通り" do
          @amount.should == 1.0
        end
        it "単位が意図通り" do
          @unit.should == "thìa cà phê"
        end
      end
      context "スペース無し" do
        before do
          @origin, @amount, @unit = FoodCalory.parse_unit("1thìa cà phê")
        end
        it "数値が意図通り" do
          @amount.should == 1.0
        end
        it "単位が意図通り" do
          @unit.should == "thìa cà phê"
        end
      end
    end

    context "lát" do
      context "正常系" do
        before do
          @origin, @amount, @unit = FoodCalory.parse_unit("4 lát")
        end
        it "数値が意図通り" do
          @amount.should == 4.0
        end
        it "単位が意図通り" do
          @unit.should == "lát"
        end
      end
      context "スペース無し" do
        before do
          @origin, @amount, @unit = FoodCalory.parse_unit("4lát")
        end
        it "数値が意図通り" do
          @amount.should == 4.0
        end
        it "単位が意図通り" do
          @unit.should == "lát"
        end
      end
    end
    context "thìa" do
      context "正常系" do
        before do
          @origin, @amount, @unit = FoodCalory.parse_unit("1/2 thìa")
        end
        it "数値が意図通り" do
          @amount.should == 0.5
        end
        it "単位が意図通り" do
          @unit.should == "thìa"
        end
      end
      context "正常系" do
        before do
          @origin, @amount, @unit = FoodCalory.parse_unit("1 thìa")
        end
        it "数値が意図通り" do
          @amount.should == 1.0
        end
        it "単位が意図通り" do
          @unit.should == "thìa"
        end
      end
    end
    context "củ" do
      context "正常系" do
        before do
          @origin, @amount, @unit = FoodCalory.parse_unit("1/2 củ")
        end
        it "数値が意図通り" do
          @amount.should == 0.5
        end
        it "単位が意図通り" do
          @unit.should == "củ"
        end
      end
      context "全角分数で数字" do
        before do
          @origin, @amount, @unit = FoodCalory.parse_unit("1/2 củ")
        end
        it "数値が意図通り" do
          @amount.should == 0.5
        end
        it "単位が意図通り" do
          @unit.should == "củ"
        end
      end
    end
    context "muỗng canh" do
      context "正常系" do
        before do
          @origin, @amount, @unit = FoodCalory.parse_unit("½ củ")
        end
        it "数値が意図通り" do
          @amount.should == 0.5
        end
        it "単位が意図通り" do
          @unit.should == "củ"
        end
      end
    end
    context "quả" do
      context "正常系" do
        before do
          @origin, @amount, @unit = FoodCalory.parse_unit("2 quả")
        end
        it "数値が意図通り" do
          @amount.should == 2.0
        end
        it "単位が意図通り" do
          @unit.should == "quả"
        end
      end
    end
    context "bát" do
      context "正常系" do
        before do
          @origin, @amount, @unit = FoodCalory.parse_unit("2 bát")
        end
        it "数値が意図通り" do
          @amount.should == 2.0
        end
        it "単位が意図通り" do
          @unit.should == "bát"
        end
      end
    end
    context "ml" do
      context "正常系" do
        before do
          @origin, @amount, @unit = FoodCalory.parse_unit("200ml")
        end
        it "数値が意図通り" do
          @amount.should == 200.0
        end
        it "単位が意図通り" do
          @unit.should == "ml"
        end
      end
    end
    context "gói" do
      context "正常系" do
        before do
          @origin, @amount, @unit = FoodCalory.parse_unit("1 gói")
        end
        it "数値が意図通り" do
          @amount.should == 1
        end
        it "単位が意図通り" do
          @unit.should == "gói"
        end
      end
    end
    context "kg" do
      context "正常系" do
        before do
          @origin, @amount, @unit = FoodCalory.parse_unit("1 kg")
        end
        it "数値が意図通り" do
          @amount.should == 1.0
        end
        it "単位が意図通り" do
          @unit.should == "kg"
        end
      end
    end
    context "hộp" do
      context "正常系" do
        before do
          @origin, @amount, @unit = FoodCalory.parse_unit("1 hộp")
        end
        it "数値が意図通り" do
          @amount.should == 1.0
        end
        it "単位が意図通り" do
          @unit.should == "hộp"
        end
      end
    end
    context "lá" do
      context "正常系" do
        before do
          @origin, @amount, @unit = FoodCalory.parse_unit("4 lá ")
        end
        it "数値が意図通り" do
          @amount.should == 4.0
        end
        it "単位が意図通り" do
          @unit.should == "lá"
        end
      end
    end
    context "chén" do
      context "正常系" do
        before do
          @origin, @amount, @unit = FoodCalory.parse_unit("1/2 chén")
        end
        it "数値が意図通り" do
          @amount.should == 0.5
        end
        it "単位が意図通り" do
          @unit.should == "chén"
        end
      end
    end
    context "ít" do
      context "正常系" do
        before do
          @origin, @amount, @unit = FoodCalory.parse_unit("1 ít")
        end
        it "数値が意図通り" do
          @amount.should == 1.0
        end
        it "単位が意図通り" do
          @unit.should == "ít"
        end
      end
    end
    context "trái" do
      context "正常系" do
        before do
          @origin, @amount, @unit = FoodCalory.parse_unit("1 trái")
        end
        it "数値が意図通り" do
          @amount.should == 1.0
        end
        it "単位が意図通り" do
          @unit.should == "trái"
        end
      end
    end
    context "nhánh" do
      context "正常系" do
        before do
          @origin, @amount, @unit = FoodCalory.parse_unit("2 nhánh")
        end
        it "数値が意図通り" do
          @amount.should == 2.0
        end
        it "単位が意図通り" do
          @unit.should == "nhánh"
        end
      end
    end
    context "nhánh" do
      context "正常系" do
        before do
          @origin, @amount, @unit = FoodCalory.parse_unit("3 tép")
        end
        it "数値が意図通り" do
          @amount.should == 3.0
        end
        it "単位が意図通り" do
          @unit.should == "tép"
        end
      end
    end
    context "muỗng cà phê" do
      context "正常系" do
        before do
          @origin, @amount, @unit = FoodCalory.parse_unit("1/4 muỗng cà phê")
        end
        it "数値が意図通り" do
          @amount.should == 0.25
        end
        it "単位が意図通り" do
          @unit.should == "muỗng cà phê"
        end
      end
    end
    context "miếng" do
      context "正常系" do
        before do
          @origin, @amount, @unit = FoodCalory.parse_unit("5 miếng")
        end
        it "数値が意図通り" do
          @amount.should == 5.0
        end
        it "単位が意図通り" do
          @unit.should == "miếng"
        end
      end
    end
    context "cái" do
      context "正常系" do
        before do
          @origin, @amount, @unit = FoodCalory.parse_unit("1 cái")
        end
        it "数値が意図通り" do
          @amount.should == 1.0
        end
        it "単位が意図通り" do
          @unit.should == "cái"
        end
      end
    end
  end
end

