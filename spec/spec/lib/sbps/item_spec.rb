# encoding: utf-8
require 'spec_helper'
require 'support/sbps_configure_context'

describe Sbps::Model::Item do
  include_context "sbps_configure"

  describe "#raw_request_params" do
    let(:item) { Sbps::Model::Item.new(:cust_code => "cust_code", :order_id => "order_id", :item_id => "1", :item_name => "item_name", :amount => 300, :cc_number => "1111111111111111", :cc_expiration => "201603", :cust_manage_flg => "1", :security_code => "123", :request_date => Time.now) }
    subject { item.raw_request_params }

    it "Hashを返すこと" do
      should be_an_instance_of Hash 
    end 

    it "merchant_idがセットされていること" do
      subject[:merchant_id].should == Sbps::Config.merchant_id
    end

    it "service_idがセットされていること" do
      subject[:service_id].should == Sbps::Config.service_id
    end

    it "cust_codeがセットされていること" do
      subject[:cust_code].should == item.cust_code
    end

    it "oreder_idがセットされていること" do
      subject[:order_id].should == item.order_id
    end

    it "item_idがセットされていること" do
      subject[:item_id].should == item.item_id
    end

    it "item_nameがセットされていること" do
      subject[:item_name].should == item.item_name
    end

    it "amountがセットされていること" do
      subject[:amount].should == item.amount.to_s
    end

    it "pay_method_infoがセットされていること" do
      subject[:pay_method_info].should be_an_instance_of Hash
    end

    it "request_dateがセットされていること" do
      subject[:request_date].should == item.request_date.strftime("%Y%m%d%H%M%S")
    end

    it "limit_secondがセットされていること" do
      subject[:limit_second].should == (60 * 30).to_s
    end
  end

  describe "#request_params" do
    let(:item) { Sbps::Model::Item.new(:cust_code => "cust_code", :order_id => "order_id", :item_id => "1", :item_name => "item_name", :amount => 300, :cc_number => "1111111111111111", :cc_expiration => "201603", :cust_manage_flg => "1", :security_code => "123", :request_date => Time.now) }
    subject { item.request_params }

    it "Hashが返ること" do
      should be_an_instance_of Hash
    end

    it "item_nameがbase64encodeされていること" do
      subject[:item_name].should == [item.item_name].pack("m").split.join   
    end
  end
end
