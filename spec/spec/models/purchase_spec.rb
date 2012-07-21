# encoding: utf-8
require 'spec_helper'

describe Purchase do
  describe ".total_of_payment" do
    before do
      @exhibited_user = FactoryGirl.create(:exhibited_user) 
      @ticket1 = FactoryGirl.create(:opening_ticket, :user => @exhibited_user)
      @ticket2 = FactoryGirl.create(:opening_ticket, :user => @exhibited_user)

      user1 = FactoryGirl.create(:user)
      user2 = FactoryGirl.create(:user)
      user3 = FactoryGirl.create(:user)
      # 前月の売上が8334
      @purchase1 = FactoryGirl.create(:purchase, :user => user1, :ticket => @ticket1, :created_at => Time.now.prev_month, :cost => 5000)
      @purchase2 = FactoryGirl.create(:purchase, :user => user2, :ticket => @ticket2, :created_at => Time.now.prev_month, :cost => 3334)

      # 前月と前々月の売上を足して5000円
      @exhibited_user2 = FactoryGirl.create(:exhibited_user)
      @ticket3 = FactoryGirl.create(:opening_ticket, :user => @exhibited_user2)
      @ticket4 = FactoryGirl.create(:opening_ticket, :user => @exhibited_user2)
      @purchase3 = FactoryGirl.create(:purchase, :user => user1, :ticket => @ticket3, :created_at => Time.now.prev_month, :cost => 4000)
      @purchase4 = FactoryGirl.create(:purchase, :user => user2, :ticket => @ticket4, :created_at => Time.now.prev_month.prev_month, :cost => 5000)
      FactoryGirl.create(:purchase, :user => user3, :created_at => Time.now, :cost => 3000)
      FactoryGirl.create(:purchase, :user => user3, :created_at => Time.now.prev_month, :cost => 3000, :paied_flag => true)


      # 前月の売上が5000円未満
      @exhibited_user3 = FactoryGirl.create(:exhibited_user)
      @ticket5 = FactoryGirl.create(:opening_ticket, :user => @exhibited_user3)
      @purchase5 = FactoryGirl.create(:purchase, :user => user1, :ticket => @ticket5, :created_at => Time.now.prev_month, :cost => 8333)
    end

    it "Paymentが保存されていること" do
      Purchase.total_of_payment 
      @purchase1.reload
      @purchase2.reload
      @purchase1.paied_flag.should be_true
      @purchase2.paied_flag.should be_true
      payment = Payment.where(:period => Time.now.prev_month.to_s(:period)).find_by_user_id(@exhibited_user.id)
      payment.cost.should == @purchase1.cost + @purchase2.cost

      @purchase3.reload
      @purchase4.reload
      @purchase3.paied_flag.should be_true
      @purchase4.paied_flag.should be_true
      payment = Payment.where(:period => Time.now.prev_month.to_s(:period)).find_by_user_id(@exhibited_user2.id)
      payment.cost.should == @purchase3.cost + @purchase4.cost

      @purchase5.reload
      @purchase5.paied_flag.should be_false
      payment = Payment.where(:period => Time.now.prev_month.to_s(:period)).find_by_user_id(@exhibited_user3.id)
      payment.should be_nil
    end
  end

  describe "#repayment" do
    let(:buy_user) { FactoryGirl.create(:user) }
    let(:sale_user) { FactoryGirl.create(:user) }
    let(:ticket) { FactoryGirl.create(:opening_ticket, :user => sale_user) }
    let(:purchase) { FactoryGirl.create(:purchase, :ticket => ticket, :user => buy_user)}
    let(:cost) { purchase.cost }

    before do
      @bill = FactoryGirl.create(:payment_bill, :user => buy_user, :cost => cost, :year => purchase.created_at.year, :month => purchase.created_at.month) 
      @sale = FactoryGirl.create(:income_bill, :user => sale_user, :cost => cost, :year => purchase.created_at.year, :month => purchase.created_at.month)
      Sbps.stub(:repayment).and_return(true)
      purchase.repayment
    end

    it "利用明細の売上金額が減ること" do
      expect {
        @sale.reload 
      }.to change(@sale, :cost).by(-cost)
    end

    it "利用明細の購入金額が減ること" do
      expect {
        @bill.reload
      }.to change(@bill, :cost).by(-cost)
    end

    it "purchaseが削除されること" do
      Purchase.find_by_id(purchase.id).should be_nil 
    end

    it "activityが削除されること" do
      Activities::Purchase.where(:user_id => buy_user.id).should == [] 
    end

    it "activity_resourceが削除されること" do
      ActivityResource.where(:resource_id => purchase.id).joins(:activity).where("activities.type = ?", "Activities::Purchase").should == [] 
    end
  end
end
