# encoding: utf-8
require "spec_helper"

describe ExhibitorMailer do

  describe ".reject" do
    before do
      @user = FactoryGirl.create(:user)
      @exhibitor = FactoryGirl.create(:exhibitor, :user => @user)
      @reason = "不採用理由"
    end
    it 'メールの件名が設定ファイルから取得した値で設定されていること' do
      ExhibitorMailer.reject(@user, @reason).subject.should == I18n.t("exhibitor.reject.subject") 
    end
    it 'メールの宛先がユーザのメールアドレスに設定されていること' do
      ExhibitorMailer.reject(@user, @reason).to.should == [@user.email]
    end
  end
end
