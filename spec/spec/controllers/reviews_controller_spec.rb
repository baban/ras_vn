# encoding: utf-8
require 'spec_helper'
require 'support/before_login_context'
require 'support/database_cleaner_context'

describe ReviewsController do
  before(:all) do
    # レビューのためのチケットを作成
    # (tickets/:ticket_id/reviews/newにいくため)
    @ticket = FactoryGirl.create(:opening_ticket)
  end

  include_context "database_cleaner"

  describe "GET new" do

    context "ログインしていない場合" do
      it "ログイン画面にリダイレクトされること" do
        get :new, :ticket_id => @ticket
        response.should redirect_to(signin_path)
      end
    end

    context "ログインしていて" do
      include_context "ログインする"

      context "商品を購入していない場合" do
        it "チケットの詳細ページにリダイレクトすること" do
          get :new, :ticket_id => @ticket
          response.should redirect_to ticket_path(@ticket)
        end
      end

      context "商品を購入していて" do

        context "未レビューの場合" do
          before do
            FactoryGirl.create(:purchase, :ticket => @ticket, :user => user)
            get :new, :ticket_id => @ticket
          end
          
          it "リクエストが成功すること" do
            response.should be_success
          end

          it "@reviewがセットされていること" do
            assigns[:review].should be_an_instance_of Review  
          end
        end

        context "レビュー済の場合" do
          before do
            FactoryGirl.create(:purchase, :ticket => @ticket, :user => user)
            FactoryGirl.create(:review, :ticket => @ticket, :user => user)
          end

          it "チケットの詳細ページにリダイレクトされること" do
            get :new, :ticket_id => @ticket
            response.should redirect_to ticket_path(@ticket)
          end
        end
      end
    end
  end

  describe "POST create" do
    context "ログインしていない場合" do
      it "ログイン画面にリダイレクトされること" do
        post :create, :review => FactoryGirl.attributes_for(:review), :ticket_id => @ticket
        response.should redirect_to(signin_path)
      end
    end

    context "ログインしていて" do
      include_context "ログインする"

      context "商品を購入していない場合" do
        it "チケットの詳細ページにリダイレクトすること" do
          post :create, :review => FactoryGirl.attributes_for(:review), :ticket_id => @ticket
          response.should redirect_to ticket_path(@ticket)
        end
      end

      context "商品を購入していて" do
        before do
          FactoryGirl.create(:purchase, :ticket => @ticket, :user => user)
        end

        context "未レビューの時に" do
          context "正しいパラメータを送った場合" do

            it "reviewが保存されること" do
              expect {
                post :create, :review => FactoryGirl.attributes_for(:review), :ticket_id => @ticket
              }.to change(Review, :count).by(1)
            end

            it "チケットの詳細ページにリダイレクトされること" do
              post :create, :review => FactoryGirl.attributes_for(:review), :ticket_id => @ticket
              response.should redirect_to ticket_path(@ticket)
            end
          end

          context "不正なパラメータを送った場合" do
            before do
              post :create, :review => nil, :ticket_id => @ticket
            end

            it "レビュー投稿画面が表示されること" do
              response.should render_template("new")
            end

            it "@reviewがセットされていること" do
              assigns[:review].should be_an_instance_of(Review)
            end
          end
        end

        context "レビュー済の時に" do
          before do
            FactoryGirl.create(:purchase, :ticket => @ticket, :user => user)
            FactoryGirl.create(:review, :ticket => @ticket, :user => user)
          end

          it "レビューが登録されないこと" do
            lambda {
              post :create, :review => FactoryGirl.attributes_for(:review), :ticket_id => @ticket
            }.should_not change(Review, :count).by(1)
          end

          it "チケットの詳細ページにリダイレクトされること" do
            post :create, :review => FactoryGirl.attributes_for(:review), :ticket_id => @ticket
            response.should redirect_to ticket_path(@ticket)
          end
        end
      end
    end
  end

  describe "DELETE destroy" do

    context "ログインしていない場合" do
      before do
        user = FactoryGirl.create(:exhibited_user)
        @review = FactoryGirl.create(:review, :user => user, :ticket => @ticket)
      end

      it "ログイン画面にリダイレクトされること" do
        delete :destroy, :ticket_id => @ticket, :id => @review
        response.should redirect_to(signin_path)
      end
    end

    context "ログインしている場合" do
      include_context "ログインする"

      before do
        @review = FactoryGirl.create(:review, :user => user, :ticket => @ticket)
      end

      it "レビューが削除されること" do
        expect {
          delete :destroy, :ticket_id => @ticket, :id => @review
        }.to change(Review, :count).by(-1)
      end

      it "チケットの詳細ページにリダイレクトされること" do
        delete :destroy, :ticket_id => @ticket, :id => @review
        response.should redirect_to ticket_path(@ticket)
      end
    end 
  end
end
