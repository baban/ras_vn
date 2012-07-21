# encoding: utf-8
require 'spec_helper'
require 'support/before_login_context'

describe ExhibitorsController do
  describe "GET new" do
    context "ログインしていない場合" do
      it "ログイン画面にリダイレクトされること" do
        get :new
        response.should redirect_to(signin_path)
      end  
    end

    context "ログインしていて" do
      include_context "ログインする"

      context "出品者の場合" do
        let(:user) { FactoryGirl.create(:exhibited_user) }

        it "出品画面にリダイレクトされること" do
          get :new 
          response.should redirect_to(new_ticket_path)
        end
      end

      context "出品者ではなく" do
        context "応募済みの場合は" do
          before do
            exhibitor = FactoryGirl.create(:exhibitor, :user => user)
          end

          it "応募完了画面にリダイレクトされること" do
            get :new
            response.should redirect_to(complete_exhibitors_path)
          end
        end

        context "未応募の場合は" do
          before do
            get :new
          end

          it "リクエストが成功すること" do
            response.should be_success 
          end 

          it "@exhibitorがセットされていること" do
            assigns[:exhibitor].should be_an_instance_of Exhibitor  
          end

          it "1MB以上のファイルをアップロードしたらエラーになること" do
            pending "atode"
          end
        end
      end
    end
  end

  describe "POST create" do
     context "ログインしていない場合" do
      it "ログイン画面にリダイレクトされること" do
        post :create, :exhibitor => FactoryGirl.attributes_for(:exhibitor) 
        response.should redirect_to(signin_path)
      end  
    end

    context "ログインしていて" do
      include_context "ログインする"

      context "出品者の場合" do
        let(:user) { FactoryGirl.create(:exhibited_user) }

        it "出品画面にリダイレクトされること" do
          post :create, :exhibitor => FactoryGirl.attributes_for(:exhibitor) 
          response.should redirect_to(new_ticket_path)
        end
      end

      context "出品者ではなく" do
        context "応募済みの場合は" do
          before do
            exhibitor = FactoryGirl.create(:exhibitor, :user => user)
          end

          it "応募完了画面にリダイレクトされること" do
            post :create, :exhibitor => FactoryGirl.attributes_for(:exhibitor) 
            response.should redirect_to(complete_exhibitors_path)
          end
        end

        context "未応募で" do
          context "正しいパラメータを送った場合" do
            before do
              post :create, :exhibitor => FactoryGirl.attributes_for(:exhibitor) 
            end

            it "exhibitorが保存されること" do
              user.exhibitor.should be_an_instance_of Exhibitor
            end

            it "応募完了画面にリダイレクトされること" do
              response.should redirect_to(complete_exhibitors_path) 
            end
          end

          context "不正なパラメータを送った場合" do
            before do
              post :create, :exhibitor => nil
            end
            
            it "応募画面が表示されること" do
              response.should render_template("new") 
            end

            it "@exhibitorがセットされていること" do
              assigns[:exhibitor].should be_an_instance_of(Exhibitor) 
            end
          end
        end
      end
    end
  end
end
