# encoding: utf-8
require 'spec_helper'

describe Activities::Purchase do
  describe "#purchase" do
    before do
      @purchase = FactoryGirl.create(:purchase)
      activity_resource = ActivityResource.find_by_resource_id @purchase.id
      @activity = Activities::Purchase.joins(:activity_resource).where("resource_id=?", @purchase.id) .readonly(false).first
    end

    it "Purchaseのインスタンスが返ること" do
      @activity.purchase.should be_an_instance_of(Purchase) 
    end  

    it "返り値が@purchaseであること" do
      @activity.purchase.should == @purchase
    end
  end

  describe ".create_from!" do
    it "Activityが保存されること" do
      purchase = FactoryGirl.create(:purchase)
      expect {
        Activities::Purchase.create_from!(purchase)
      }.should change(Activity, :count).by(1)
    end 
  end

end
