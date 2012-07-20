# encoding: utf-8
require 'spec_helper'

describe Activities::Ticket do
  describe "#ticket" do
    before do
      @ticket = FactoryGirl.create(:opening_ticket)
      @activity = Activities::Ticket.joins(:activity_resource).where("resource_id=?", @ticket.id) .readonly(false).first
    end
    
    it "Ticketのインスタンスが返ること" do
      @activity.ticket.should == @ticket
    end
  end

  describe ".before_update_from!" do
    context "初めての公開であれば" do
      it "Activitiesが保存されること" do
        ticket = FactoryGirl.create(:ticket)
        ticket.stub(:create_notification?).and_return(true)
        ticket.stub(:is_first_open?).and_return(true)
        expect {
          Activities::Ticket.before_update_from!(ticket) 
        }.should change(Activity, :count).by(1)
      end
    end

    context "初めての公開でなければ" do
      it "Activitiesが保存されないこと" do
        ticket = FactoryGirl.create(:ticket)
        ticket.stub(:create_notification?).and_return(true)
        ticket.stub(:is_first_open?).and_return(false)
        expect {
          Activities::Ticket.before_update_from!(ticket) 
        }.should change(Activity, :count).by(0)
      end
    end
  end
end
