# -*- coding: utf-8 -*-
require 'spec_helper'

describe Bills::Income do
  describe "#enter_bill!" do
    before do
      @user1 = FactoryGirl.create(:user)
      @user2 = FactoryGirl.create(:user)
      @ticket = FactoryGirl.create(:ticket, :user => @user1)
      @purchase = FactoryGirl.create(:purchase, :ticket => @ticket, :user => @user1)
    end

    context "今月分の売り上げ利用明細が既に存在するならば" do
      before do
        @bill = FactoryGirl.create(:income_bill, :user => @user1)
      end
      it "売り上げの値段が加算されること" do
        expect {
          Bills::Income.enter_bill!(@user1, @purchase)
          @bill.reload
        }.should change(@bill, :cost).by(@purchase.cost)
      end
    end

    context "今月分の売り上げ利用明細が存在しないならば" do
      it "新たに売り上げ明細レコードが作られること" do
        expect {
          Bills::Income.enter_bill!(@user1, @purchase)
        }.should change(Bills::Income, :count).by(1)
      end
    end
  end
end
