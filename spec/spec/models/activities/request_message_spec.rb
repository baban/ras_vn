# encoding: utf-8
require 'spec_helper'

describe Activities::RequestMessage do
  describe "#request_message" do
    before do
      user = FactoryGirl.create(:user)
      @request_message = FactoryGirl.create(:request_message, :user => user)
      @activity = Activities::RequestMessage.joins(:activity_resource).where("resource_id=?", @request_message.id) .readonly(false).first
    end

    it "RequestMessageのインスタンスが返ること" do
      @activity.request_message.should be_an_instance_of(RequestMessage) 
    end

    it "返り値が@request_messageであること" do
      @activity.request_message.should == @request_message
    end
  end
  describe ".create_from!" do
    it "Activityが一件保存されること" do
      user = FactoryGirl.create(:user)
      @request_message = FactoryGirl.create(:request_message, :user => user)
      expect {
        Activities::RequestMessage.create_from!(@request_message)
      }.should change(Activities::RequestMessage, :count).by(1)
    end  
  end
end
