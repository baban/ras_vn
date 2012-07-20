# encoding: utf-8
require 'spec_helper'
require 'support/sbps_configure_context'

describe Sbps::Model::CreditCard do
  include_context "sbps_configure"

  describe "#raw_request_params" do
    let(:credit_card) { Sbps::Model::CreditCard.new(:cc_number => "1111111111111111", :cc_expiration => "201603", :cust_manage_flg => "1", :security_code => "111", :encrypted_flg => 1) }
    subject { credit_card.raw_request_params }

    it "Hashを返すこと" do
      should be_an_instance_of Hash 
    end 

    it "pay_method_infoがHashであること" do
      subject[:pay_method_info].should be_an_instance_of Hash
    end

    it "pay_method_infoにcc_numberセットされていること" do
     subject[:pay_method_info][:cc_number].should == credit_card.cc_number
    end

    it "pay_method_infoにcc_expirationセットされていること" do
     subject[:pay_method_info][:cc_expiration].should == credit_card.cc_expiration
    end
    
    it "pay_method_infoにsecurity_codeセットされていること" do
     subject[:pay_method_info][:security_code].should == credit_card.security_code
    end
    
    it "pay_method_infoにcust_manage_flgセットされていること" do
     subject[:pay_method_info][:cust_manage_flg].should == credit_card.cust_manage_flg
    end

    it "encrypted_flgがセットされていること" do
      subject[:encrypted_flg].should == credit_card.encrypted_flg.to_s
    end
  end

  describe "#request_params" do
    let(:credit_card) { Sbps::Model::CreditCard.new(:cc_number => "1111111111111111", :cc_expiration => "201603", :cust_manage_flg => "1", :security_code => "111", :encrypted_flg => 1) }
    subject { credit_card.request_params }

    it "Hashを返すこと" do
      should be_an_instance_of Hash 
    end 

    it "pay_method_infoがHashであること" do
      subject[:pay_method_info].should be_an_instance_of Hash
    end

    it "pay_method_infoにcc_numberセットされていること" do
     subject[:pay_method_info][:cc_number].should == credit_card.tripple_des(credit_card.cc_number)
    end

    it "pay_method_infoにcc_expirationセットされていること" do
     subject[:pay_method_info][:cc_expiration].should == credit_card.tripple_des(credit_card.cc_expiration)
    end
    
    it "pay_method_infoにsecurity_codeセットされていること" do
     subject[:pay_method_info][:security_code].should == credit_card.tripple_des(credit_card.security_code)
    end
    
    it "pay_method_infoにcust_manage_flgセットされていること" do
     subject[:pay_method_info][:cust_manage_flg].should == credit_card.tripple_des(credit_card.cust_manage_flg)
    end

    it "encrypted_flgがセットされていること" do
      subject[:encrypted_flg].should == credit_card.encrypted_flg.to_s
    end
  end
end
