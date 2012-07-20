# -*- coding: utf-8 -*-
require 'spec_helper'

describe RecommendUser do
  describe ".update_score" do
    include_context "database_cleaner"

    before do
      # 出品をしているユーザー
      @ticket_user = FactoryGirl.create(:user) 
      FactoryGirl.create(:ticket, :user => @ticket_user) 

      # 管理者
      @admin_user1 = FactoryGirl.create(:admin_user) 
      @admin_user2 = FactoryGirl.create(:admin_user) 
      note = FactoryGirl.create(:note, :user => @admin_user1) 

      # その他の方々
      @other_user = FactoryGirl.create(:user) 
      FactoryGirl.create(:note_comment, :note => note, :user => @other_user) 

      RecommendUser.update_score
    end

    it "チケット出品者にスコアが付けられていること" do
      RecommendUser.find_by_user_id(@ticket_user.id).should be_present
    end

    context "対象のユーザーが管理者の場合" do
      it "ボードを呟くなどしていれば、おすすめユーザーに登録されていること" do
        RecommendUser.find_by_user_id(@admin_user1.id).should be_present
      end

      it "何もしなければ、おすすめユーザーに登録されないこと" do
        RecommendUser.find_by_user_id(@admin_user2.id).should be_blank
      end
    end

    it "出品者でも管理者でもないユーザーはお勧めユーザーに登録されないこと" do
    end
  end
end
