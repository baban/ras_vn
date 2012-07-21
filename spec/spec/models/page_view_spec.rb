# encoding: utf-8
require 'spec_helper'

describe PageView do
  describe ".clean" do
    before do
      ticket = FactoryGirl.create(:opening_ticket)
      4.times do
        FactoryGirl.create(:page_view, :ticket => ticket)
      end
      FactoryGirl.create(:page_view, :ticket => ticket, :created_at => 31.days.ago)
    end

    it "30日以上前のデータが削除されること" do
      expect {
        PageView.clean 
      }.should change(PageView, :count).from(5).to(4)
    end
  end
end
