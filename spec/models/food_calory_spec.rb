# encoding: utf-8

require 'spec_helper'

describe FoodCalory do
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
  end
end

