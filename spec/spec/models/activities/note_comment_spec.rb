# encoding: utf-8
require 'spec_helper'

describe Activities::NoteComment do
  describe "#note" do
    before do
      user = FactoryGirl.create(:user)
      user2 = FactoryGirl.create(:user)
      @note = FactoryGirl.create(:note, :user => user)
      note_comment = FactoryGirl.create(:note_comment, :note => @note, :user => user2)
      @activity = Activities::NoteComment.joins(:activity_resource).where("resource_id=?", note_comment.id) .readonly(false).first
    end

    it "Noteのインスタンスが返ること" do
      @activity.note.should be_an_instance_of(Note) 
    end

    it "返り値が@noteであること" do
      @activity.note.should == @note
    end
  end

  describe "#note_comment" do
    before do
      user = FactoryGirl.create(:user)
      user2 = FactoryGirl.create(:user)
      @note = FactoryGirl.create(:note, :user => user2)
      @note_comment = FactoryGirl.create(:note_comment, :note => @note, :user => user)
      activity_resource = ActivityResource.joins(:activity).where("activities.type"=> "Activities::NoteComment").find_by_resource_id(@note_comment.id)
      @activity = Activity.find activity_resource.activity_id
    end    

    it "NoteCommentのインスタンスが返ること" do
      @activity.note_comment.should be_an_instance_of(NoteComment) 
    end

    it "@note_commentであること" do
      @activity.note_comment.should == @note_comment
    end
  end

  describe ".create_from!" do
    it "Activitiesが保存されること" do
      user = FactoryGirl.create(:user)
      user2 = FactoryGirl.create(:user)
      note = FactoryGirl.create(:note, :user => user)
      note_comment = FactoryGirl.create(:note_comment, :note => note, :user => user2)
      expect {
        Activities::NoteComment.create_from!(note_comment)
      }.should change(Activity, :count).by(1)
    end
  end
end
