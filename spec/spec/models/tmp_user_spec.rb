# encoding: utf-8
require 'spec_helper'

describe TmpUser do

  describe "#service_for_registration" do
    before do
      @tmp_user = FactoryGirl.create(:tmp_user)
    end

    it "Serviceの子クラスのインスタンスであること" do
      @tmp_user.service_for_registration.should be_an_kind_of(Service)  
    end

    it "返り値にuidを含むこと" do
      @tmp_user.service_for_registration.uid.should_not be_nil
    end

    it "返り値にaccess_tokenを含むこと" do
      @tmp_user.service_for_registration.access_token.should_not be_nil    
    end
  end
end
