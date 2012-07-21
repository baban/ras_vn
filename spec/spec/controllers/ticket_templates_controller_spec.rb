# encoding: utf-8
require 'spec_helper'
require 'support/database_cleaner_context'
require 'support/before_login_context'

describe TicketTemplatesController do
  describe "GET show" do
    render_views
    before(:all) do
      @ticket_template = FactoryGirl.create(:ticket_template)
    end
    include_context "database_cleaner"

    context "ログインしていなかったら" do
      it "ログイン画面にリダイレクトされること" do
        get :show, :id => @ticket_template.id, :format => "json"
        response.body.should == {:require_login => "/signin"}.to_json
      end
    end

    context "ログインしていて" do
      include_context "ログインする"
     
      context "ticket_templateが存在すれば" do
        it "ticket_templateのjsonが返ること" do
          get :show, :id => @ticket_template.id, :format => "json"
          response.body.should == @ticket_template.to_json
        end
      end

      context "ticket_templateが存在しなければ" do
        it "error用のjsonが返ること" do
          get :show, :id => "hoge", :format => "json"
          response.body.should == {:success => false}.to_json
        end
      end
    end
  end
end
