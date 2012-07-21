# encoding: utf-8
require 'spec_helper'

describe WelcomeHelper do
  describe "#recent_comments" do
    let(:ticket) { FactoryGirl.create(:opening_ticket) }
    let(:count) { 3 }
    subject { recent_comments(ticket, count) } 
    context "チケットにコメントが無い場合" do
      it "空のリストが返ること" do
        should == []
      end  
    end
    context "チケットにコメントが1件ある場合" do
      before { FactoryGirl.create(:note, :ticket => ticket) } 
      it "1件のnoteが返ること" do
        should have(1).items
      end
    end
    context "チケットにコメントが3件ある場合" do
      before do
        3.times { FactoryGirl.create(:note, :ticket => ticket) } 
      end
      it "3件のnoteが返ること" do
        should have(3).items
      end  
    end
    context "チケットにコメントが5件ある場合" do
      before do
        5.times { FactoryGirl.create(:note, :ticket => ticket) } 
      end
      it "3件のnoteが返ること" do
        should have(3).items
      end  
      context "2件取得指定をした時" do
        let(:count) { 2 }
        it "2件のnoteが返ること" do
          should have(2).items
        end  
      end
    end
  end
end
