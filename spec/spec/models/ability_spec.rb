# encoding: utf-8
require 'spec_helper'
require "cancan/matchers"

describe Ability do
  describe "#initialize" do
    subject { ability }
    let(:ability){ Ability.new(user) }

    context "一般ユーザーの場合" do
      let(:user){ FactoryGirl.create(:user) }
      it{ should_not be_able_to(:manage, Admin) }
      it{ should_not be_able_to(:manage, Conversation) }
      it{ should_not be_able_to(:manage, Payment) }
      it{ should_not be_able_to(:manage, RejectionTicket) }
      it{ should_not be_able_to(:manage, Review) }
      it{ should_not be_able_to(:manage, StatisticsReport) }
      it{ should_not be_able_to(:manage, TicketTemplate) }
      it{ should_not be_able_to(:manage, Ticket) }
      it{ should_not be_able_to(:manage, User) }
      it{ should_not be_able_to(:index, Exhibitor) }
      it{ should_not be_able_to(:show, Exhibitor) }
      it{ should_not be_able_to(:adopt, Exhibitor) }
      it{ should_not be_able_to(:destroy, Exhibitor) }
    end
    context "Abilie管理者の場合" do
      let(:user){ FactoryGirl.create(:admin_user) }
      it{ should be_able_to(:manage, Admin) }
      it{ should be_able_to(:manage, Conversation) }
      it{ should be_able_to(:manage, Payment) }
      it{ should be_able_to(:manage, Purchase) }
      it{ should be_able_to(:manage, RejectionTicket) }
      it{ should be_able_to(:manage, Review) }
      it{ should be_able_to(:manage, StatisticsReport) }
      it{ should be_able_to(:manage, TicketTemplate) }
      it{ should be_able_to(:manage, Ticket) }
      it{ should be_able_to(:manage, User) }
      it{ should be_able_to(:index, Exhibitor) }
      it{ should be_able_to(:show, Exhibitor) }
      it{ should be_able_to(:adopt, Exhibitor) }
      it{ should be_able_to(:destroy, Exhibitor) }
    end
    context "ユーコム管理者の場合" do
      let(:user){ FactoryGirl.create(:user_communication_user) }
      it{ should be_able_to(:manage, Admin) }
      it{ should be_able_to(:manage, Conversation) }
      it{ should_not be_able_to(:manage, Payment) }
      it{ should_not be_able_to(:manage, RejectionTicket) }
      it{ should be_able_to(:manage, Review) }
      it{ should_not be_able_to(:manage, StatisticsReport) }
      it{ should_not be_able_to(:manage, TicketTemplate) }
      it{ should_not be_able_to(:manage, Ticket) }
      it{ should_not be_able_to(:manage, User) }
      it{ should_not be_able_to(:index, Exhibitor) }
      it{ should_not be_able_to(:show, Exhibitor) }
      it{ should_not be_able_to(:adopt, Exhibitor) }
      it{ should_not be_able_to(:destroy, Exhibitor) }
    end
    context "財務管理者の場合" do
      let(:user){ FactoryGirl.create(:financial_affairs_user) }
      it{ should be_able_to(:manage, Admin) }
      it{ should_not be_able_to(:manage, Conversation) }
      it{ should be_able_to(:manage, Payment) }
      it{ should be_able_to(:index, Purchase) }
      it{ should_not be_able_to(:destroy, Purchase) }
      it{ should_not be_able_to(:manage, RejectionTicket) }
      it{ should_not be_able_to(:manage, Review) }
      it{ should_not be_able_to(:manage, StatisticsReport) }
      it{ should_not be_able_to(:manage, TicketTemplate) }
      it{ should_not be_able_to(:manage, Ticket) }
      it{ should_not be_able_to(:manage, User) }
      it{ should_not be_able_to(:index, Exhibitor) }
      it{ should_not be_able_to(:show, Exhibitor) }
      it{ should_not be_able_to(:adopt, Exhibitor) }
      it{ should_not be_able_to(:destroy, Exhibitor) }
    end
    context "開発者の場合" do
      let(:user) { FactoryGirl.create(:develop_user) }
      it { should be_able_to(:manage, StatisticsReport) }
      it { should be_able_to(:index, User) }
      it { should be_able_to(:show, User) }
      it { should be_able_to(:admin, User) }
      it { should be_able_to(:change_admin_type, User) }
    end
    context "userのexhibitorフラグがtrueならば" do
      let(:user){ FactoryGirl.create(:exhibited_user) }
      it{ should be_able_to(:edit, Exhibitor) }
      it{ should be_able_to(:update, Exhibitor) }
    end
    context "userのexhibitorフラグがfalseならば" do
      let(:user){ FactoryGirl.create(:user) }
      it{ should_not be_able_to(:edit, Exhibitor) }
      it{ should_not be_able_to(:update, Exhibitor) }
    end
  end
end
