# encoding: utf-8
require "spec_helper"

describe Distributer do
  let(:user) { FactoryGirl.create(:user) }
  before do
    FactoryGirl.create(:top_sale_ticket)
  end

  describe ".pickup" do
    before do
      @time = Time.now
      @tickets = Ticket.pickup
    end
    it 'メールの件名が設定ファイルから取得した値で設定されていること' do
      Distributer.pickup(user,@tickets,@time).subject.should == I18n.t("distributer.pickup.subject", :month => @time.month, :day => @time.day) 
    end
    it 'メールの宛先がユーザのメールアドレスに設定されていること' do
      Distributer.pickup(user,@tickets,Time.now).to.should == [user.email]
    end
  end

  describe ".responded" do
    before do
      @ticket = FactoryGirl.create(:opening_ticket) 
    end

    it 'メールの件名が設定ファイルから取得した値で設定されていること' do
      Distributer.responded(user,@ticket).subject.should == I18n.t("distributer.responded.subject", :name => @ticket.title) 
    end

    it 'メールの宛先がユーザのメールアドレスに設定されていること' do
      Distributer.responded(user,@ticket).to.should == [user.email]
    end
  end
end
