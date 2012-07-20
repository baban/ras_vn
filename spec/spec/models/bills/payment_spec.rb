# -*- coding: utf-8 -*-
require 'spec_helper'

describe Bills::Payment do
  describe "#enter_bill!" do
    before do
      @user1 = FactoryGirl.create(:user)
      @user2 = FactoryGirl.create(:user)
      @ticket = FactoryGirl.create(:ticket)
      @purchase = FactoryGirl.create(:purchase, :ticket => @ticket, :user => @user1)
    end

    context "今月分の購入利用明細が既に存在するならば" do
      before do
        @bill = FactoryGirl.create(:payment_bill, :user => @user1)
      end
      it "購入の値段が加算されること" do
        expect {
          Bills::Payment.enter_bill!(@user1, @purchase)
          @bill.reload
        }.should change(@bill, :cost).by(@purchase.cost)
      end
    end

    context "今月分の購入利用明細が存在しないならば" do
      it "新たに購入明細レコードが作られること" do
        expect {
          Bills::Payment.enter_bill!(@user2, @purchase)
        }.should change(Bills::Payment, :count).by(1)
      end
    end
  end
end
