# encoding: utf-8
require 'spec_helper'

describe Campaigns::Review do
  describe "#qualified?" do
    let(:ticket) { FactoryGirl.create(:opening_ticket) }
    let(:campaign) { FactoryGirl.create(:review_campaign) }
    let(:user) { FactoryGirl.create(:user) }
    let(:opening_ticket) { FactoryGirl.create(:ticket) }
    subject { campaign.qualified?(user) }

    after(:all) do
      # 時刻操作をもとに戻す
      Timecop.return
    end

    context "キャンペーン開始日前の場合" do
      before do
        Timecop.freeze campaign.start_at.yesterday 
      end

      it { should be_false }
    end

    context "キャンペーン応募締め切り後の場合" do
      before do
        Timecop.freeze campaign.entry_closed_at.tomorrow
      end

      it { should be_false }
    end

    context "キャンペーン期間中で" do
      before do
        Timecop.freeze campaign.closed_at.yesterday
      end

      context "このキャンペーンに応募済みであれば" do
        before do
          FactoryGirl.create(:review_campaign_entry, :user => user, :campaign => campaign)
        end

        it { should be_false }
      end

      context "キャンペーン未応募で" do
        context "期間中にレビューを書いていない場合は" do
          before do
            FactoryGirl.create(:review, :user => user, :ticket => ticket, :created_at => campaign.start_at.yesterday)
          end

          it { should be_false } 
        end 

        context "期間中にレビューを書いていて" do
          before do
            FactoryGirl.create(:review, :user => user, :ticket => ticket)
          end

          context "期間中に500円以上のチケットを購入してなければ" do
            before do
              FactoryGirl.create(:purchase, :user => user, :created_at => campaign.start_at.yesterday)
              FactoryGirl.create(:purchase, :user => user, :cost => 300)
            end

            it { should be_false} 
          end

          context "期間中に500円以上のチケットを購入していれば" do
            before do
              FactoryGirl.create(:purchase, :user => user, :ticket => ticket)
            end

            it { should be_true }
          end
        end
      end
    end
  end

  describe "#period" do
    let(:campaign) { FactoryGirl.build(:review_campaign) }
  
    subject { campaign.period }
    it "Rangeオブジェクトが返ること" do
      should be_an_instance_of Range
    end
  end
end
