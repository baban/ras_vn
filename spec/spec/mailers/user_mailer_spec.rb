# encoding: utf-8
require "spec_helper"

describe UserMailer do
  describe ".auth_email" do
    before do
      @user = FactoryGirl.create(:user)
    end
    it 'ファイルから取得した値で設定されていること' do
      UserMailer.auth_email(@user).subject.should == I18n.t("user.new.subject")
    end
    it 'メールの宛先がユーザのメールアドレスに設定されていること' do
      UserMailer.auth_email(@user).to.should == [@user.email]
    end
  end

  describe ".edit_email" do
    before do
      @user = FactoryGirl.create(:user)
    end
    it 'ファイルから取得した値で設定されていること' do
      UserMailer.edit_email(@user).subject.should == I18n.t("user.edit.subject")
    end
    it 'メールの宛先がユーザのメールアドレスに設定されていること' do
      UserMailer.edit_email(@user).to.should == [@user.email]
    end
  end

  describe ".reset_password" do
    before do
      @user = FactoryGirl.create(:user)
    end
    it 'ファイルから取得した値で設定されていること' do
      UserMailer.reset_password(@user).subject.should == I18n.t("user.reset_password.subject")
    end
    it 'メールの宛先がユーザのメールアドレスに設定されていること' do
      UserMailer.reset_password(@user).to.should == [@user.email]
    end
  end

  describe ".forgot_abilie_id" do
    before do
      @user = FactoryGirl.create(:user)
    end
    it 'ファイルから取得した値で設定されていること' do
      UserMailer.forgot_abilie_id(@user.email).subject.should == I18n.t("user.forgot_abilie_id.subject")
    end
    it 'メールの宛先が入力のメールアドレスに設定されていること' do
      UserMailer.forgot_abilie_id(@user.email).to.should == [@user.email]
    end
  end
end
