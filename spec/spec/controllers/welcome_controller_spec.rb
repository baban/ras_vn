# encoding: utf-8
require 'spec_helper'
require 'support/database_cleaner_context'

describe WelcomeController do

  describe "GET 'index'" do
    before(:all) do
      # 今は top_sale の機能は使われていない
      #FactoryGirl.create(:top_sale_ticket)
      user = FactoryGirl.create(:vip_user)
      2.times do
        FactoryGirl.create(:hot_ticket, :user => user)
      end

      11.times do
        FactoryGirl.create(:opening_ticket, :user => user)
      end
    end

    include_context "database_cleaner"

    before do
      get :index
    end

    it "should be successful" do
      response.should be_success
    end

    it "@ticketsが2件あること" do
      assigns[:premium_tickets].should have(2).items 
    end
  end
end
