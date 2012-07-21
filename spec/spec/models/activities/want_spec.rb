# encoding: utf-8
require 'spec_helper'

describe Activities::Want do
  describe "#want" do
    before do
      user = FactoryGirl.create(:user)
      request_message = FactoryGirl.create(:request_message)
      @want = FactoryGirl.create(:want, :user => user, :request_message => request_message)
      @activity = Activities::Want.joins(:activity_resource).where("resource_id=?", @want.id) .readonly(false).first
    end
    it "Wantのインスタンスが返ること" do
      @activity.want.should be_an_instance_of(Want) 
    end

    it "返り値が@wantであること" do
      @activity.want.should == @want
    end
  end
  describe ".create_from!" do
    it "Activityが一件保存されること" do
      user = FactoryGirl.create(:user)
      @want = FactoryGirl.create(:want, :user => user)
      expect {
        Activities::Want.create_from!(@want)
      }.should change(Activities::Want, :count).by(1)
    end  
  end
end
