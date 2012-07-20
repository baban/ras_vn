# encoding: utf-8
require 'spec_helper'

describe Favorite do
  describe "#favoriteable?" do
    before do
      @user = FactoryGirl.create(:user)
      @user2 = FactoryGirl.create(:user)
      @favorite = FactoryGirl.create(:favorite, :user => @user)
    end

    context "お気に入りしたユーザーと引数のユーザーが異なる場合" do
      it "trueになること" do
        @favorite.favoriteable?(@user2).should be_true
      end
    end
    
    context "お気に入りしたユーザーと引数のユーザーが同じ場合" do
      it "falseになること" do
        @favorite.favoriteable?(@user).should be_false
      end
    end
  end
  
  describe "#deletable?" do
    before do
      @user = FactoryGirl.create(:user)
      @user2 = FactoryGirl.create(:user)
      @favorite = FactoryGirl.create(:favorite, :user => @user)
    end

    context "お気に入りしたユーザーと引数のユーザーが同じ場合" do
      it "trueになること" do
        @favorite.deletable?(@user).should be_true 
      end 
    end  

    context "お気に入りしたユーザーと引数のユーザーが異なる場合" do
      it "falseになること" do
        @favorite.deletable?(@user2).should be_false
      end
    end
  end
end
