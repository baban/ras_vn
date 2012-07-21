# encoding: utf-8
require 'spec_helper'
require 'support/before_login_context'

describe MessagesController do

  describe "GET download" do
    let(:conversation) { FactoryGirl.create(:conversation) }
    let(:user1) { FactoryGirl.create(:user) }
    let(:user2) { FactoryGirl.create(:user) }
    let(:message) { FactoryGirl.create(:message, :conversation => conversation, :user => user1, :to_user => user2, :file => File.open(Rails.root.to_s + "/spec/support/images/nikujaga.jpg"))} 

    before do
      FactoryGirl.create(:conversation_member, :conversation => conversation, :user => user1)
      FactoryGirl.create(:conversation_member, :conversation => conversation, :user => user2)
    end

    it "routingされること" do
      {:get => message.file.url.gsub("\/spec\/support","")}.should route_to(:controller => "messages", :action => "download", :number => "file_0", :id => message.id.to_s, :basename => "nikujaga", :extension => "jpg")
    end

    context "ログインしていない場合" do
      it "ログイン画面にリダイレクトされること" do
        get :download, :number => "file_0", :id => message.id, :basename => "nikujaga", :extension => "jpg"
        response.should redirect_to(signin_path)
      end
    end 

    context "ログインしていて" do
      include_context "ログインする" 
      
      context "ファイルの送信者の場合" do
        let(:user) { user1 }

        before do
          controller.should_receive(:send_file).with(message.file.path, :x_sendfile => true) 
          controller.stub!(:render)
        end

        it "ファイルをダウンロードできること" do
          get :download, :number => 0, :id => message.id, :basename => "nikujaga", :extension => "jpg"
        end
      end

      context "ファイルの受信者の場合" do
        let(:user) { user2 }
        before do
          controller.should_receive(:send_file).with(message.file.path, :x_sendfile => true) 
          controller.stub!(:render)
        end

        it "ファイルをダウンロードできること" do
          get :download, :number => 0, :id => message.id, :basename => "nikujaga", :extension => "jpg"
        end  
      end

      context "管理者の場合" do
        let(:user) { FactoryGirl.create(:admin_user) } 

        before do
          controller.should_receive(:send_file).with(message.file.path, :x_sendfile => true) 
          controller.stub!(:render)
        end

        it "ファイルをダウンロードできること" do
          get :download, :number => 0, :id => message.id, :basename => "nikujaga", :extension => "jpg"
        end  
      end

      context "送信者でも受信者でもない場合" do
        it "ファイルをダウンロード出来ないこと" do
          lambda {
            get :download, :number => 0, :id => message.id, :basename => "nikujaga", :extension => "jpg"
          }.should raise_error ActiveRecord::RecordNotFound
        end
      end
    end
  end
end
