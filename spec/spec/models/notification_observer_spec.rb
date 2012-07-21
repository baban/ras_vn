# encoding: utf-8
require 'spec_helper'

describe NotificationObserver do
  describe "#after_create" do
    pending "resqueに書き換えたのでやりなおし"
    #before do
    #  Delayed::Job.all.each &:destroy
    #  Delayed::Worker.delay_jobs = true
    #  @observer = NotificationObserver.instance
    #end

    #context "friendshipがcreateされた時" do
    #  it "delayed_jobsにデータが登録されること" do
    #    @friendship = Friendship.create(:user_id => 1, :friend_id => 2)
    #    @observer.after_create(@friendship)
    #    Delayed::Job.all.should_not be_empty
    #  end 
    #end

    #after do
    #  Delayed::Worker.delay_jobs = false
    #end
  end
end
