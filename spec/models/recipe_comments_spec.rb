# encoding: utf-8

require 'spec_helper'

describe RecipeComment do
  fixtures :users, :user_profiles, :user_profile_visibilities, :recipe_comments

  describe "#prof" do
    before do
      @comment = RecipeComment.first
    end
    it "投稿したユーザーのプロフィールを取得する" do
      @comment.prof.should be_instance_of UserProfile
      @comment.prof.user_id.should == 1
    end
  end
end
