# encoding: utf-8
require "spec_helper"

describe CampaignMailer do
  describe ".review" do
    let(:user) { FactoryGirl.create(:user) }
    let(:ticket) { FactoryGirl.create(:ticket) }

    subject { CampaignMailer.review(user, ticket) }

    before do
      FactoryGirl.create(:review_campaign)
    end

    it 'メールの宛先がユーザのメールアドレスに設定されていること' do
      subject.to.should == [user.email]
    end

    it "タイトルが設定されていること" do
      subject.subject.should == I18n.t("campaign.review.subject")
    end
  end
end
