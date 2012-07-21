# -*- coding: utf-8 -*-
require 'spec_helper'

describe Services::Twitter do
  describe "#client" do
    let(:service) { FactoryGirl.build(:twitter_service) }
    subject { service.client }

    it "Twitterクラスが返ること" do
      should == Twitter
    end  

    it "consumer_keyがsetされていること" do
      subject.consumer_key.should == "RzJlWn7neK6XCxR2P6XYg"
    end

    it "consumer_secretがsetされていること" do
      subject.consumer_secret.should == "um4Oih77pR2LdqaKIJpnXXOG73mhKUn378vOOTefYc" 
    end

    it "oauth_tokenがsetされていること" do
      subject.oauth_token.should == service.access_token_decrypt
    end

    it "oauth_token_secretがsetされていること" do
      subject.oauth_token_secret.should == service.access_secret_decrypt
    end
  end

  describe ".get_original_image" do
    it "画像のurlの\"_normal\"が\"\"に置換されてimageに登録されること" do
      Services::Twitter.get_original_image("hogehoge_normal_moge_normal.png").should == "hogehoge_normal_moge.png"
    end
  end
end
