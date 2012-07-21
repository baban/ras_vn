# encoding: utf-8
require 'spec_helper'

describe Sbps::Config do
  describe ".configure" do
    subject { 
      Sbps::Config.configure do |config|
        config.merchant_id = "hoge"
      end
    }
    it "Configのインスタンスが返ること" do
      should == Sbps::Config
    end 

    it "merchant_idがセットされていること" do
      subject.merchant_id == "hoge" 
    end
  end
end
