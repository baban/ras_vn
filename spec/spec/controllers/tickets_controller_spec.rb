# encoding: utf-8
require 'spec_helper'
require 'support/database_cleaner_context'

describe TicketsController do

  shared_examples_for "exhibitor?" do
    it "出品者応募画面にリダイレクトされること" do
      response.should redirect_to new_exhibitor_path  
    end
  end
  
  describe "GET 'index'" do
    before(:all) do
      13.times do
        FactoryGirl.create(:opening_ticket)
      end
    end

    include_context "database_cleaner"

    context "一覧ページにアクセスした場合" do
      before do
        get :index
      end

      it 'index のテンプレートが読まれること' do
        response.should render_template('index')
      end

      it "@ticketsが12件あること(チャンクは12件)" do
        assigns[:tickets].should have(12).items 
      end
    end
    context "一覧ページの2ページ目にアクセスした場合" do
      before do
        get :index, :page => 2
      end

      it 'index のテンプレートが読まれること' do
        response.should render_template('index')
      end

      it "@ticketsが3件あること(チャンクは12件。データは13件)" do
        assigns[:tickets].should have(1).items 
      end
    end
    context "一覧ページの3ページ目（データがないページ）にアクセスした場合" do
      before do
        get :index, :page => 3
      end

      it 'index のテンプレートが読まれること' do
        response.should render_template('index')
      end

      it "@ticketsが0件あること" do
        assigns[:tickets].should have(0).items 
      end
    end
  end

  describe "GET 'show/:id'" do
    context "存在しないチケットにアクセスした場合" do
      it "404になること" do
        lambda {
          get :show, :id => "not_found"
        }.should raise_error ActiveRecord::RecordNotFound
      end  
    end

    context "公開中でないチケットにアクセスした場合" do
      let(:ticket) { FactoryGirl.create(:ticket) }
      it "404になること" do
        lambda {
          get :show, :id => ticket.id
        }.should raise_error ActiveRecord::RecordNotFound
      end 
    end

    context "公開中のチケットにアクセスした場合" do
      before(:all) do
        @ticket = FactoryGirl.create(:opening_ticket)
        4.times do
          FactoryGirl.create(:review, :ticket => @ticket, :user => FactoryGirl.create(:user))
        end

        11.times do
          FactoryGirl.create(:note, :user => @ticket.user)
        end

        2.times do
          FactoryGirl.create(:opening_ticket, :category => @ticket.category)
        end

      end

      include_context "database_cleaner"

      before do
        get :show, :id => @ticket.id
      end


      it "リクエストが成功すること" do
        response.should be_success 
      end      

      it "@ticketがTicketのインスタンスがあること" do
        assigns[:ticket].should == @ticket 
      end

      it "@reviewsが最大4件あること" do
        assigns[:reviews].should have(4).items 
      end

      it "チケットの出品者の一言が最大10件あること" do
        assigns[:notes].should have(10).items 
      end

      it "関連チケットが最大2件あること" do
        assigns[:related_tickets].should have(2).items 
      end
    end

    context "販売終了したチケットにアクセスした場合" do
      before(:all) do
        @ticket = FactoryGirl.create(:closed_ticket)
     end

      before do
        get :show, :id => @ticket.id
      end
      it "リクエストが成功すること" do
        
      end

      it "@ticketがTicketのインスタンスがあること" do
        assigns[:ticket].should == @ticket 
      end
    end
  end

  describe "GET new" do
    before do
      controller.stub(:current_user).and_return(user)
      get :new
    end

    context "ログインしていなかったら" do
      let(:user) { nil }
      it_behaves_like "require_login"
    end  

    context "ログインしていたら" do
     let(:user) { FactoryGirl.create(:exhibited_user) }

     it "リクエストが成功すること" do
       response.should be_success          
     end  

     it "@ticketにTicketのインスタンスがセットされていること" do
       assigns[:ticket].should be_an_instance_of Ticket 
     end
    end
  end

  describe "POST create" do
    let(:ticket_params) { FactoryGirl.attributes_for(:ticket, :category_id => FactoryGirl.create(:category).id) }

    before do
      controller.stub(:current_user).and_return(user)
    end

    context "ログインしていなかったら" do
      let(:user) { nil }
      before do
        post :create, :ticket => ticket_params
      end

      it_behaves_like "require_login"
    end  

    context "ログインしていて" do
      let(:user) { FactoryGirl.create(:exhibited_user) }
      context "正しいパラメータを送信すれば" do
        it "Ticketが保存されること" do
          expect {
            post :create, :ticket => ticket_params
          }.to change(Ticket, :count).by(1)
        end

        it "編集画面にリダイレクトされること" do
          post :create, :ticket => ticket_params
          response.should redirect_to edit_ticket_path(Ticket.last) 
        end
      end
      
      context "不正なパラメータを送信した場合" do
        let(:ticket_params) { nil }
        before do
          post :create, :ticket => ticket_params
        end

        it "新規投稿画面が表示されること" do
          response.should render_template(:new)
        end

        it "@ticketにTicketのインスタンスがセットされていること" do
          assigns[:ticket].should be_an_instance_of Ticket
        end
      end
    end
  end

  describe "GET edit" do
    let(:user) { FactoryGirl.create(:exhibited_user) }
    let(:ticket) { FactoryGirl.create(:ticket) }

    before do
      controller.stub(:current_user).and_return(user)
      get :edit, :id => ticket
    end
    
    context "ログインしていなかったら" do
      let(:user) { nil }
      it_behaves_like "require_login"
    end  

    context "ログインしていて" do
      context "編集可能であれば" do
        let(:ticket) { FactoryGirl.create(:ticket, :user => user) }

        it "リクエストが成功すること" do
          response.should be_success 
        end  

        it "@ticketに指定したticketがセットされていること" do
          assigns[:ticket].should == ticket 
        end
      end  

      context "編集不可能であれば" do
        it "トップページにリダイレクトされること" do
          response.should redirect_to root_path 
        end 
      end
    end
  end

  describe "PUT update" do
    let(:user) { FactoryGirl.create(:exhibited_user) }
    let(:ticket) { FactoryGirl.create(:ticket) }
    let(:ticket_params) { FactoryGirl.attributes_for(:ticket, :title => "change") }
    let(:submit_button) { I18n.t("ticket.submit_button.publish") }

    before do
      controller.stub(:current_user).and_return(user)
      put :update, :id => ticket, :ticket => ticket_params, :commit => submit_button
    end

    context "ログインしていなかったら" do
      let(:user) { nil }
      it_behaves_like "require_login"
    end  

    context "ログインしていて" do
      context "編集可能で" do
        let(:ticket) { FactoryGirl.create(:ticket, :user => user) }

        context "正しいパラメータで" do
          context "審査に提出するボタンが押されたら" do
            it "完了画面にリダイレクトされること" do
              response.should redirect_to accepted_ticket_path(ticket.id)  
            end

            it "チケットが審査中になっていること" do
              ticket.reload
              ticket.release_status.should == Ticket::RELEASE_STATUS["examining"]
            end

            it "チケットが更新されていること" do
              ticket.reload 
              ticket.title.should == "change"
            end
          end

          context "動画をアップロードするボタンが押されたら" do
            let(:submit_button) { I18n.t("ticket.submit_button.video") }
            it "動画投稿画面にリダイレクトされること" do
              response.should redirect_to new_ticket_video_path(ticket.id)  
            end

            it "チケットが下書きになっていること" do
              ticket.reload
              ticket.release_status.should == Ticket::RELEASE_STATUS["draft"]
            end

            it "チケットが更新されていること" do
              ticket.reload 
              ticket.title.should == "change"
            end
          end

          context "PDFをアップロードするボタンが押されたら" do
            let(:submit_button) { I18n.t("ticket.submit_button.pdf") }
            it "PDFアップロード画面にリダイレクトされること" do
              response.should redirect_to new_ticket_pdf_path(ticket)
            end

            it "チケットが下書きになっていること" do
              ticket.reload
              ticket.release_status.should == Ticket::RELEASE_STATUS["draft"]
            end

            it "チケットが更新されていること" do
              ticket.reload 
              ticket.title.should == "change"
            end
          end

        end

        context "不正なパラメータを送れば" do
          let(:ticket_params) { {:title => nil } }

          it "編集画面が表示されること" do
            response.should render_template(:edit) 
          end

          it "@ticketにticketがセットされていること" do
            assigns[:ticket].should == ticket 
          end
        end
      end  

      context "編集不可能であれば" do
        it "トップページにリダイレクトされること" do
          response.should redirect_to root_path 
        end 
      end
    end 
  end

  describe "GET preview" do
    let(:user) { FactoryGirl.create(:exhibited_user) }
    let(:ticket) { FactoryGirl.create(:ticket) }

    before do
      controller.stub(:current_user).and_return(user)
      get :preview, :id => ticket
    end

    context "ログインしていなかったら" do
      let(:user) { nil }
      it_behaves_like "require_login"
    end  

    context "ログインしていて" do
      context "編集可能であれば" do
        let(:ticket) { FactoryGirl.create(:ticket, :user => user) }

        it "リクエストが成功すること" do
          response.should be_success  
        end  

        it "@ticketに指定したticketがセットされていること" do
          assigns[:ticket].should == ticket 
        end
      end  

      context "編集不可能であれば" do
        it "トップページにリダイレクトされること" do
          response.should redirect_to root_path 
        end 
      end
    end 
  end

  describe "GET popular" do
    before(:all) do
      13.times do
        FactoryGirl.create(:opening_ticket)
      end
    end

    include_context "database_cleaner"

    context "一覧ページにアクセスした場合" do
      before do
        get :popular
      end

      it 'index のテンプレートが読まれること' do
        response.should render_template('index')
      end
      it "@ticketsが12件あること(チャンクは12件)" do
        assigns[:tickets].should have(12).items 
      end
    end
  end

  describe "GET affiliate" do

    context "アフィリエイト経由でチケット詳細ページに飛ぼうとした場合" do
      let(:ticket) { create(:opening_ticket) }
      let(:affiliate) { create(:affiliate) }
      let(:session_id) { "hogehoge" }
      before do
        request.session_options[:id] = session_id
        Affiliate.stub(:find_by_key).and_return(affiliate)
      end

      it "affiliate_idがredisに保存されること" do
        affiliate.should_receive(:setup).with(session_id)
        get :via, :id => ticket.id, :aid => affiliate.key
      end

      it "チケット詳細にとぶこと" do
        get :via, :id => ticket.id, :aid => affiliate.key
        response.should redirect_to ticket_path(ticket)
      end
    end
  end

  describe "GET search(/:q)" do
    let(:query) { "hoge" }
    include_context "database_cleaner"

    context "保存するリクエストなら" do
      before { controller.stub(:save_search_log?).and_return(true) }
      it "検索履歴が保存されること" do
        expect { get :search, :q => query}.to change(SearchLog, :count).by(1)
      end
    end
    context "保存しないリクエストなら" do
      before { controller.stub(:save_search_log?).and_return(false) }
      it "検索履歴が保存されないこと" do
        expect { get :search, :q => query}.to_not change(SearchLog, :count)
      end
    end

  end
  describe "#ticket_templates" do
    before(:all) do
      3.times do 
        FactoryGirl.create(:ticket_template)
      end
    end

    include_context "database_cleaner"

    subject { controller.send(:ticket_templates) }

    it "ticket_templateが3つあること" do
      should have(3).items
    end
  end

  describe "#save_search_log?" do
    before { controller.stub(:crawler?).and_return(crawler) } 
    let(:search_log) { FactoryGirl.create(:search_log) }
    let(:query) { "query" }
    let(:crawler) { false }
    subject {controller.send("save_search_log?", query)}

    context "クローラーの場合" do
      let(:crawler) { true }
      it "falseを返すこと" do
        should be_false  
      end 
    end
    context "クローラーでない場合" do
      it "trueを返すこと" do
        should be_true  
      end 
    end
    context "クエリーが空の場合" do
      let(:query) { "" }
      it "falseを返すこと" do
        should be_false  
      end 
    end
    context "クエリーがnilの場合" do
      let(:query) { nil }
      it "falseを返すこと" do
        should be_false  
      end 
    end
    context "クエリが存在する場合" do
      it "trueを返すこと" do
        should be_true  
      end 
    end

    context "同じキーワードで検索された場合" do
      let(:query) { search_log.word }
      context "同じセッションの場合" do
        before { request.session_options[:id] = search_log.session_id }
        context "有効期限内なら" do
          it "falseを返すこと" do
            should be_false
          end 
        end
        context "保存期間外なら" do
          before { Timecop.freeze 3.days.since }
          after { Timecop.return }
          it "trueを返すこと" do
            should be_true  
          end 
        end
      end
      context "異なるセッションの場合" do
        before { request.session_options[:id] = "tigau" }
        it "trueを返すこと" do
          should be_true  
        end
      end
    end
    context "異なるキーワードで検索された場合" do
      context "同じセッションの場合" do
        before { request.session_options[:id] = search_log.session_id }
        it "trueを返すこと" do
          should be_true  
        end
      end
      context "異なるセッションの場合" do
        before { request.session_options[:id] = "tigau" }
        it "trueを返すこと" do
          should be_true  
        end
      end
    end
  end
end

