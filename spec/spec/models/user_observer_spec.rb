# -*- coding: utf-8 -*-
require 'spec_helper'

describe UserObserver do
  describe "#set_auth_code_to_redis(user) " do
    pending "mail 用のスペックどうしようかな"
=begin
    before do
      @user = FactoryGirl.create(:user)
      @observer = UserObserver.instance
    end
    context "userがcreateされた時" do
      it "メールが送信されること" do
        @user = User.create(:name => "Bob", :email => "email@hogehoge.jp")
        @observer.after_create(@user)
      end
    end 
=end
  end
end
