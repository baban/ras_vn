# encoding: utf-8
require 'spec_helper'

describe Activities::Review do
  describe "#review" do
    before do
      @user = FactoryGirl.create(:user)
      @ticket = FactoryGirl.create(:ticket)
      @review = FactoryGirl.create(:review, :ticket => @ticket, :user => @user)
      @activity = Activities::Review.joins(:activity_resource).where("resource_id=?", @review.id) .readonly(false).first
    end

    it "Reviewのインスタンスが返ること" do
      @activity.review.should be_an_instance_of(Review) 
    end  

    it "返り値が@reviewであること" do
      @activity.review.should == @review
    end
  end

  describe ".create_from!" do
    it "Activityが1件保存されること" do
      @user = FactoryGirl.create(:user)
      @ticket = FactoryGirl.create(:ticket)
      @review = FactoryGirl.create(:review, :ticket => @ticket, :user => @user)
      expect {
        Activities::Review.create_from!(@review) 
      }.should change(Activity, :count).by(1)
    end 
  end
end
