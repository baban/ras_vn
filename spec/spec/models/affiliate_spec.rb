# -*- coding: utf-8 -*-
require 'spec_helper'

describe Affiliate do
  describe "#create_key" do
    let(:affiliate) { create(:affiliate) }
    subject { affiliate.create_key }

    it "アフィリエイト用にString型のkeyが作られること" do
      should be_an_instance_of String
    end
  end

  describe "#setup" do
    let(:affiliate) { create(:affiliate) }
    let(:session_id) { "hogehoge" }
    context "セッションにアフィリエイトがすでに登録されている場合" do
      before do
        Abilie::Redis.connection.stub!(:exists).and_return(true)
      end
      subject { affiliate.setup(session_id) }
      it "nilが返ること" do
        should be_nil
      end
    end

    context "セッションにアフィリエイトが未登録の場合" do
      let(:redis_key) { Abilie::Redis::Affiliate::AFFILIATE_PREFIX + ":" + session_id }
      before do
        Abilie::Redis.connection.stub!(:exists).and_return(false)
        affiliate.setup(session_id)
      end
      it "redisにアフィリエイトがセットされること" do
        Abilie::Redis.connection.get(redis_key).should == affiliate.id.to_s
      end
      it "redisにexpireががセットされること" do
        Abilie::Redis.connection.ttl(redis_key).should be_present
      end
    end
  end

  describe ".find_affiliate_id" do
    let(:session_id) { "hogehoge" }
    let(:redis_key) { Abilie::Redis::Affiliate::AFFILIATE_PREFIX + ":" + session_id }
    it "session_idを条件にredisからアフィリエイトIDを検索していること" do
      Abilie::Redis.connection.should_receive(:get).with(redis_key)
      Affiliate.find_affiliate_id(session_id)
    end
  end
end
