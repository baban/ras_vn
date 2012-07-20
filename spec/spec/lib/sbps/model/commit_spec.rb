# encoding: utf-8
require 'spec_helper'
require 'support/sbps_configure_context'

describe Sbps::Model::Commit do
  include_context "sbps_configure"

  describe "#raw_request_params" do
    let(:commit) { Sbps::Model::Commit.new(1, Time.now) }
    subject { commit.raw_request_params }

    it "Hashを返すこと" do
      should be_an_instance_of Hash 
    end 

    it "merchant_idがセットされていること" do
      subject[:merchant_id].should == Sbps::Config.merchant_id
    end

    it "service_idがセットされていること" do
      subject[:service_id].should == Sbps::Config.service_id
    end

    it "sps_transaction_idがセットされていること" do
      subject[:sps_transaction_id].should == commit.sps_transaction_id 
    end

    it "request_dateがセットされていること" do
      subject[:request_date].should == commit.request_date.strftime("%Y%m%d%H%M%S")
    end

    it "limit_secondがセットされていること" do
      subject[:limit_second].should == (60 * 30).to_s
    end
  end

  describe "#request_params" do
    let(:commit) { Sbps::Model::Commit.new(1, Time.now) }
    subject { commit.request_params }

    it "Hashを返すこと" do
      should be_an_instance_of Hash 
    end 

    it "merchant_idがセットされていること" do
      subject[:merchant_id].should == Sbps::Config.merchant_id
    end

    it "service_idがセットされていること" do
      subject[:service_id].should == Sbps::Config.service_id
    end

    it "sps_transaction_idがセットされていること" do
      subject[:sps_transaction_id].should == commit.sps_transaction_id 
    end

    it "request_dateがセットされていること" do
      subject[:request_date].should == commit.request_date.strftime("%Y%m%d%H%M%S")
    end

    it "limit_secondがセットされていること" do
      subject[:limit_second].should == (60 * 30).to_s
    end

    it "sps_hashcodeがセットされていること" do
      subject[:sps_hashcode].should be_an_instance_of String
    end
  end
end
