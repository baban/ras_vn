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

  context :validate do
    let(:prms) do
      {
        recipe_id: 1,
        user_id: 1,
        title: "aaaaa",
        content: "aaaa",
      }
    end
    context "正常系" do
      before do
        @comment = RecipeComment.new
        @comment.attributes= prms
      end
      it "成功する" do
        @comment.valid?.should be_true
      end
    end

    context "本文なし" do
      before do
        @comment = RecipeComment.new
        @prms = prms
        @prms[:content]=nil
        @comment.attributes= @prms
      end
      it "チェック失敗" do
        @comment.valid?.should be_false
      end
    end
  end
end
