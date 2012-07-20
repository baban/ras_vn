# encoding: utf-8
require 'spec_helper'
require 'support/database_cleaner_context'

describe Review do
  describe "validation" do
    context "ticket_idとuser_idの組み合わせがすでに保存されている場合" do
      before(:all) do
        user = FactoryGirl.create(:user)
        ticket = FactoryGirl.create(:ticket)
        review1 = FactoryGirl.build(:review, :user => user, :ticket => ticket) 
        @review2 = FactoryGirl.build(:review, :user => user, :ticket => ticket) 
        review1.save
      end

      include_context "database_cleaner"

      subject { @review2 }

      it "保存できないこと" do
        should_not be_valid
      end
    
      it ":ticket_idにエラーが設定されていること" do
        should have(1).errors_on(:ticket_id) 
      end
    end
  end

  describe "#own?" do
    before(:all) do
      @user = FactoryGirl.create(:user)
      @ticket = FactoryGirl.create(:ticket)
      @review = FactoryGirl.create(:review, :user => @user, :ticket => @ticket) 
    end

    include_context "database_cleaner"

    subject { @review.own?(user) }

    context "レビューを書いたユーザーと引数のユーザーが同じ場合" do
      let(:user) { @review.user }
      it "trueになること" do
        should be_true 
      end
    end

    context "レビューを書いたユーザーと引数のユーザーが異なる場合" do
      let(:user) { FactoryGirl.create(:user) }
      it "falseになること" do
        should be_false
      end
    end

    context "引数がnilの場合" do
      let(:user) { nil }
      it "falseになること" do
        should be_false
      end 
    end
  end

  describe ".total_of_rating" do
    before do
      @ticket = FactoryGirl.create(:opening_ticket)
      @ticket2 = FactoryGirl.create(:opening_ticket)
      @ticket3 = FactoryGirl.create(:opening_ticket, :user => @ticket2.user)
      @user = FactoryGirl.create(:user)
      @user2 = FactoryGirl.create(:user)
      @user3 = FactoryGirl.create(:user)
      FactoryGirl.create(:review, :ticket => @ticket, :user => @user, :rating => 3)
      FactoryGirl.create(:review, :ticket => @ticket, :user => @user2, :rating => 2)
      FactoryGirl.create(:review, :ticket => @ticket2, :user => @user, :rating => 5)
      FactoryGirl.create(:review, :ticket => @ticket2, :user => @user2, :rating => 4)
      FactoryGirl.create(:review, :ticket => @ticket2, :user => @user3, :rating => 5)
      FactoryGirl.create(:review, :ticket => @ticket3, :user => @user, :rating => 1)
      Review.total_of_rating
      @ticket.reload  
      @ticket2.reload
      @ticket3.reload
    end

    it "チケットのレートが集計されていること" do
      @ticket.rating.should == 50
      @ticket2.rating.should == 93
    end  

    it "ユーザーのレートが集計されていること" do
      @ticket.user.rating.should == 50
      @ticket2.user.rating.should == 75
    end
  end
end
