# encoding: utf-8
require 'spec_helper'

describe PurchasesHelper do
  describe "#affiliate_tag" do
    subject { helper.affiliate_tag } 

    context "productionでない場合" do
      it "blankが返ること" do
        should be_empty
      end 
    end

    context "productionの場合" do
      before do
        Rails.env = "production"
        user = FactoryGirl.create(:admin_user)
        ticket = FactoryGirl.create(:ticket)
        @purchase = FactoryGirl.create(:purchase, :user => user, :ticket => ticket)
        helper.stub!(:current_user).and_return(user)
      end

      after do
        Rails.env = "test"
      end

      it "imgタグが返ること" do
        should match(/img/)
      end

      it "imgタグのsrcにorder_idが含まれること" do
        should match(/order_id=production_#{@purchase.id}/)
      end
    end
  end
end
