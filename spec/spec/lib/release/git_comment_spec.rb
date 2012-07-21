# encoding: utf-8
require 'spec_helper'
require 'grit'

describe Release::GitComment do
  describe ".clone_repository" do
    let(:repository) { "repository" }
    subject { Release::GitComment.clone_repository repository }

    it "Release::GitCommetのインスタンスが返ること" do
      should be_instance_of Release::GitComment
    end
  end

  describe "#git_clone" do
    let(:target) { Release::GitComment.new "repository" }
    before do
      @mock_grit = mock("Grit::Git")
      Grit::Git.stub!(:new).and_return(@mock_grit)
    end

    it "git-cloneがおこなわれること" do
      @mock_grit.should_receive(:clone).with(an_instance_of(Hash), target.repository, target.location)
      target.git_clone
    end
  end

  describe "#recent_comments" do
    let(:target) { Release::GitComment.new "repository" }

    def stub_tags(*message)
      ret = []
      message.each do |mes|
        mock_tag = mock("Grit::Tag")
        mock_tag.stub!(:tag_date).and_return(Time.now)
        mock_tag.stub!(:message).and_return(mes)
        ret << mock_tag
        sleep 1
      end
      ret
    end

    context "リポジトリにタグが存在する場合" do
      before do
        @mock_repo = mock("Grit::Repo")
        @mock_repo.stub!(:tags).and_return(stub_tags("hoge", "moge\nhoge"))
        Grit::Repo.stub!(:new).and_return(@mock_repo)
      end
      subject { target.recent_comments }
      it "最新のタグを取得すること" do
        should == ["moge","hoge"]
      end
      it "コメントのリストが返ること" do
        should be_instance_of Array
      end
    end

    context "タグが存在しない場合" do
      before do
        @mock_repo = mock("Grit::Repo")
        @mock_repo.stub!(:tags).and_return([])
        Grit::Repo.stub!(:new).and_return(@mock_repo)
      end
      subject { target.recent_comments }
      it "nilが返ること" do
        should be_nil
      end
    end
  end
end
