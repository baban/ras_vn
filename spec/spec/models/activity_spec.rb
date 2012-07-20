# encoding: utf-8
require 'spec_helper'

describe Activity do
  before do 
    @user = FactoryGirl.create(:user)
    @activity = @user.activities.build
  end

  describe "#partial" do
    it "'activities/activity'が返ること" do
      @activity.partial.should == "activities/activity"  
    end
  end

  describe "#set_public" do
    it "public_flagがtrueになること" do
      expect {
        @activity.set_public
      }.should change(@activity, :public_flag).from(false).to(true)
    end     
  end

  describe ".child_class" do
    it "Purchaseを引数に渡すと、Activities::Purchaseクラスが返ること" do
      Activity.child_class("Purchase").should == Activities::Purchase
    end 
  end
end
