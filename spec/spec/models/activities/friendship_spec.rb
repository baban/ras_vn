# encoding: utf-8
require 'spec_helper'

describe Activities::Friendship do
  describe "#to_user_list(count=nil)" do
    before do
      @user = FactoryGirl.create(:user)
      user2 = FactoryGirl.create(:user)
      user3 = FactoryGirl.create(:user)
      @friendship1 = FactoryGirl.create(:friendship, :user => @user, :friend => user2)
      @friendship2 = FactoryGirl.create(:friendship, :user => @user, :friend => user3)
      @activity = Activities::Friendship.joins(:activity_resource).where("resource_id=?", @friendship1.id) .readonly(false).first
    end

    it "フォローしたユーザー一覧が返ること" do
      @activity.to_user_list.should .should == User.find([@friendship1.friend_id, @friendship2.friend_id])
    end

    it "引数にカウントを指定すれば取得数に制限がかかること" do
      @activity.to_user_list(1).size.should .should == 1 
    end
  end

  describe "#user_num" do
    before do
      @user = FactoryGirl.create(:user)
      user2 = FactoryGirl.create(:user)
      user3 = FactoryGirl.create(:user)
      @friendship1 = FactoryGirl.create(:friendship, :user => @user, :friend => user2)
      @friendship2 = FactoryGirl.create(:friendship, :user => @user, :friend => user3)
      activity_resource = ActivityResource.find_by_resource_id @friendship1.id
      @activity = Activity.find activity_resource.activity.id
    end

    it "フォローしたユーザー数が返ること" do
      @activity.user_num.should .should == 2 
    end
  end

  describe ".create_from!" do
    context "一日以内に同一ユーザーのフォロー情報がある場合" do
      it "Activitiesに登録されるのは１件のみで、該当データがupdateされること" do
        @user = FactoryGirl.create(:user)
        @user2 = FactoryGirl.create(:user)
        @user3 = FactoryGirl.create(:user)
        expect { 
          @friendship1 = FactoryGirl.create(:friendship, :user => @user, :friend => @user2)
          @friendship2 = FactoryGirl.create(:friendship, :user => @user, :friend => @user3)
          Activities::Friendship.create_from!(@friendship1)
          Activities::Friendship.create_from!(@friendship2)
        }.should change(Activity, :count).by(1)
      end  
    end

    context "一日以内に同一ユーザーのフォロー情報がない場合" do
      it "Activitiesが保存されること" do
        user = FactoryGirl.create(:user)
        user2 = FactoryGirl.create(:user)
        expect { 
          @friendship = FactoryGirl.create(:friendship, :user => user, :friend => user2)
          Activities::Friendship.create_from!(@friendship)
        }.should change(Activity, :count).by(1)
      end  
    end
  end

  describe ".delete_from!" do
    context "bodyにuser_idが２つ以上登録されている場合" do
      it "Activitiesのカラムの数は変わらないこと" do
        user = FactoryGirl.create(:user)
        user2 = FactoryGirl.create(:user)
        user3 = FactoryGirl.create(:user)
        @friendship1 = FactoryGirl.create(:friendship, :user => user, :friend => user2)
        @friendship2 = FactoryGirl.create(:friendship, :user => user, :friend => user3)
        expect { 
          Activities::Friendship.delete_from!(@friendship1)
        }.should change(Activity, :count).by(0)
      end
    end

    context "bodyにuser_idが1つしか登録されていない場合" do
      it "Activitiesが削除されること" do
        user = FactoryGirl.create(:user)
        user2 = FactoryGirl.create(:user)
        @friendship = FactoryGirl.create(:friendship, :user => user, :friend => user2)
        expect { 
          Activities::Friendship.delete_from!(@friendship)
        }.should change(Activity, :count).by(-1)
      end
    end
  end
end
