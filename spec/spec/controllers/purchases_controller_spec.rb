# encoding: utf-8
require 'spec_helper'

describe PurchasesController do
  let(:user) { create(:user, :last_login_at => Time.now) }
  let(:ticket) { create(:opening_ticket) }

  before do
    controller.stub(:current_user).and_return(user)
  end

  describe "GET new" do
    before do
      get :new, :ticket_id => ticket.id
    end

    it "リクエストが成功すること" do
      response.should be_success   
    end

    it "@credit_cardにSbps::Model::CreditCardのインスタンスがセットされていること" do
      assigns[:credit_card].should be_an_instance_of Sbps::Model::CreditCard
    end
  end

  describe "POST settle" do
    context "購入要求に成功した場合" do
      before do
        response = mock(Sbps::Response)
        response.stub(:error?).and_return(false)
        response.stub(:body).and_return({"res_sps_transaction_id" => "456"})
        Sbps.stub(:settle).and_return(response)
        post :settle, :ticket_id => ticket.id, :credit => {:expiration => {:year => 2016, :month => 4}, :number => "1111222233334444", :security_code => "123"}
      end

      it "tmp_purchaseにtransaction_idが保存されていること" do
        TmpPurchase.where(:ticket_id => ticket.id).where(:user_id => user.id).where(:transaction_id => "456").should have(1).item
      end

      it "confirmが表示されること" do
        response.should render_template("purchases/confirm")
      end

      it "@responseがセットされていること" do
        assigns[:response].should_not be_nil
      end
      
    end

    context "購入要求に失敗した場合" do
      before do
        response = mock(Sbps::Response)
        response.stub(:error?).and_return(true)
        response.stub(:error).and_return("test error")
        Sbps.stub(:settle).and_return(response)

        post :settle, :ticket_id => ticket.id, :credit => {:expiration => {:year => 2016, :month => 4}, :number => "1111222233334444", :security_code => "123"}
      end

      it "newが表示されること" do
        response.should render_template("purchases/new")
      end
      
      it "@credit_cardにSbps::Model::CreditCardのインスタンスがセットされていること" do
        assigns[:credit_card].should be_an_instance_of Sbps::Model::CreditCard
      end
    end
  end

  describe "POST create" do
    context "transaction_idが保存されていない場合" do
      it "購入画面にリダイレクトされること" do
        post :create, :ticket_id => ticket.id
        response.should redirect_to(new_ticket_purchase_path(ticket)) 
      end 
    end  

    context "transaction_idが保存されていて" do
      before do
        create(:tmp_purchase, :ticket => ticket, :user => user)
      end

      context "購入確定に失敗した場合" do
        before do
          response = mock(Sbps::Response)
          response.stub(:error?).and_return(true)
          response.stub(:error).and_return("test error")
          Sbps.stub(:commit).and_return(response)
        end

        it "購入画面にリダイレクトされること" do
          post :create, :ticket_id => ticket.id
          response.should redirect_to(new_ticket_purchase_path(ticket)) 
        end 
      end 

      context "購入確定に成功した場合" do
        before do
          response = mock(Sbps::Response)
          response.stub(:error?).and_return(false)
          response.stub(:body).and_return({"res_sps_transaction_id" => "456"})
          Sbps.stub(:commit).and_return(response)
        end

        describe "アフィリエイト経由の時" do
          let(:affiliate) { create(:affiliate) }

          before do
            Affiliate.stub(:find_affiliate_id).and_return(affiliate.id)
          end

          it "affiliate_idが保存されること" do
            post :create, :ticket_id => ticket.id 
            Purchase.last.affiliate_id.should == affiliate.id
          end
        end

        it "Purchaseが保存されること" do
          expect {
            post :create, :ticket_id => ticket.id 
          }.to change(Purchase, :count).by(1)
        end

        it "購入完了画面にリダイレクトされること" do
          post :create, :ticket_id => ticket.id 
          response.should redirect_to(complete_ticket_purchases_path(ticket))
        end
      end
    end
  end

  describe "GET complete" do
    context "チケットを購入済みであれば" do
      before do
        create(:purchase, :user => user, :ticket => ticket)
        4.times do
          create(:opening_ticket, :category => ticket.category, :user => ticket.user)
        end
        get :complete, :ticket_id => ticket.id
      end

      it "@ticketがセットされていること" do
        assigns[:ticket].should == ticket  
      end 

      it "@ticketsに同一カテゴリの人気のチケットが4件セットされていること" do
        assigns[:tickets].should have(4).items
      end
    end

    context "チケットを未購入であれば" do
      before do
        get :complete, :ticket_id => ticket.id
      end

      it "チケット画面へリダイレクトされること" do
        response.should redirect_to(ticket_path(ticket)) 
      end
    end
  end
end
