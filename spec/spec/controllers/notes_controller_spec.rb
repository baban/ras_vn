# encoding: utf-8
require 'spec_helper'

describe NotesController do
  describe "#redirect_after_create" do
    before do
        @user = FactoryGirl.create(:user)
        @note = FactoryGirl.create(:note, :in_reply_to_user => @user)
        controller.instance_variable_set(:@note, @note)
    end
    subject { controller.send(:redirect_after_create) }
    context "redirect_to指定がない場合" do
      before { @controller.stub(:params).and_return({}) }
      it ":backを返すこと" do
        should eq :back
      end
    end
    context "redirect_to指定がuser_boardの場合" do
      before { @controller.stub(:params).and_return({:redirect_to => "user_board"}) }
      it "in_reply_to_userのボードパスを返すこと" do
        should eq boards_user_path(@user.url_name)
      end
    end
  end
end
