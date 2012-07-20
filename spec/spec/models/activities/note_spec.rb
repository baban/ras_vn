# encoding: utf-8
require 'spec_helper'

describe Activities::Note do
  describe "#note" do
    before do
      user = FactoryGirl.create(:user)
      @note = FactoryGirl.create(:note, :user => user)
      activity_resource = ActivityResource.find_by_resource_id @note.id
      @activity = activity_resource.activity
      @activity = Activities::Note.joins(:activity_resource).where("resource_id=?", @note.id) .readonly(false).first
    end

    it "Noteのインスタンスが返ること" do
      @activity.note.should be_an_instance_of(Note) 
    end

    it "返り値が@noteであること" do
      @activity.note.should == @note
    end
  end

  describe ".create_from!" do
    it "Activityが一件保存されること" do
      user = FactoryGirl.create(:user)
      @note = FactoryGirl.create(:note, :user => user)
      expect {
        Activities::Note.create_from!(@note)
      }.should change(Activity, :count).by(1)
    end  
  end
end
