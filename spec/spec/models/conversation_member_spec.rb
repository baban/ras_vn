# -*- coding: utf-8 -*-
require 'spec_helper'

describe ConversationMember do
  describe ".sendable_members" do
    let(:user) { FactoryGirl.create(:exhibited_user) }
    subject { ConversationMember.sendable_members(user) }

    before do
      3.times do
        conversation = FactoryGirl.create(:conversation)
        user2 = FactoryGirl.create(:user)
        FactoryGirl.create(:conversation_member, :conversation => conversation, :user => user)
        FactoryGirl.create(:conversation_member, :conversation => conversation, :user => user2)
      end
    end

    it "メッセージ送信可能なユーザーが3人いること" do
      should have(3).items
    end
  end
end
