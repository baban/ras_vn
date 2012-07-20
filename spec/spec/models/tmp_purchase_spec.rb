# encoding: utf-8
require 'spec_helper'

describe TmpPurchase do
  describe "#create_order_id" do
    
  end

  describe ".find_touch_or_create" do
    let(:user) { create(:user) }
    let(:ticket) { create(:opening_ticket) }

    subject { TmpPurchase.find_touch_or_create(ticket, user) }

    context "指定したチケットとユーザーで作られたtmp_purchaseがある場合" do
      before do
        @tmp_purchase = create(:tmp_purchase, :user => user, :ticket => ticket, :updated_at => Time.now.yesterday)
      end

      it "tmp_purchaseのupdated_atが更新されること" do
        expect {
          subject
          @tmp_purchase.reload
        }.to change(@tmp_purchase, :updated_at)
      end

      it "tmp_purchaseのインスタンスが返ること" do
        should be_an_instance_of TmpPurchase
      end
    end

    context "指定したチケットとユーザーで作られたtmp_purchaseがない場合" do
      it "tmp_purchaseが作成されること" do
        expect {
          subject
        }.to change(TmpPurchase, :count).by(1)
      end

      it "tmp_purchaseのインスタンスが返ること" do
        should be_an_instance_of TmpPurchase
      end
    end
  end
end
