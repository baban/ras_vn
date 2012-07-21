# encoding: utf-8
require 'spec_helper'

describe Service do
  describe ".child_class" do
    context "facebookを指定したら" do
      it "Services::Facebookクラスが返ること" do
        Service.child_class("facebook").should == Services::Facebook
      end
    end
  end

  describe "#facebook?" do
    subject { service.facebook? }

    context "Services::Facebookであれば" do
      let(:service) { FactoryGirl.build(:facebook_service) }
      it "trueになること" do
        should be_true    
      end
    end

    context "Services::Facebookでなければ" do
      let(:service) { FactoryGirl.build(:twitter_service) }
      it "falseになること" do
        should be_false
      end
    end
  end

  describe "#twitter?" do
    subject { service.twitter? }

    context "Services::Twitterであれば" do
      let(:service) { FactoryGirl.build(:twitter_service) }
      it "trueになること" do
        should be_true    
      end
    end

    context "Services::Twitterでなければ" do
      let(:service) { FactoryGirl.build(:facebook_service) }
      it "falseになること" do
        should be_false
      end
    end
  end
end
