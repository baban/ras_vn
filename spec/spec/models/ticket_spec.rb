# -*- coding: utf-8 -*-
require 'spec_helper'

describe Ticket do
  describe "validation" do
    let(:ticket) { FactoryGirl.build(:opening_ticket) }
    subject { ticket }

    context ":titleが空の場合" do
      let(:ticket) { FactoryGirl.build(:opening_ticket, :title => nil) }

      it "validationに失敗すること" do
        should_not be_valid
      end   

      it ":titleにエラーが設定されていること" do
        should have(1).errors_on(:title)
      end   
    end

    context ":priceが空で" do
      context "下書き状態であれば" do
        let(:ticket) { FactoryGirl.build(:draft_ticket, :price => "") }
        
        it "validationに成功すること" do
          should be_valid 
        end
      end

      context "下書き状態でなければ" do
        let(:ticket) { FactoryGirl.build(:examining_ticket, :price => "") }
        it "validationに失敗すること" do
          should_not be_valid
        end

        it ":priceにエラーが設定されていること" do
          should have(1).errors_on(:price)
        end
      end
    end

    context "descriptionが空で" do
      context "下書き状態であれば" do
        let(:ticket) { build(:draft_ticket, :description => "") }

        it "validationに成功すること" do
          should be_valid   
        end
      end

      context "下書き状態でなければ" do
        let(:ticket) { build(:examining_ticket, :description => "") }

        it "validationに失敗すること" do
          should_not be_valid
        end
      end
    end

    context ":descriptionの長さが5000以上の場合" do
      let(:ticket) { FactoryGirl.build(:opening_ticket, :description => ("h" * 5001)) }

      it "validationに失敗すること" do
        should_not be_valid
      end

      it ":descriptionにエラーが設定されていること" do
        should have(1).errors_on(:description)
      end
    end

    context "delivery_periodが空で" do
      context "下書き状態であれば" do
        let(:ticket) { build(:draft_ticket, :delivery_period => "") }

        it "validationに成功すること" do
          should be_valid   
        end
      end

      context "下書き状態でなければ" do
        let(:ticket) { build(:examining_ticket, :delivery_period => "") }

        it "validationに失敗すること" do
          should_not be_valid
        end
      end
    end

    context ":category_idに存在しないカテゴリが指定されていた場合" do
      let(:ticket) { 
        ticket = FactoryGirl.build(:ticket) 
        ticket.category_id = Category.last.id + 1
        ticket
      }

      it "validationに失敗すること" do
        should_not be_valid 
      end

      it ":category_idにエラーが設定されていること" do
        should have(1).errors_on(:category) 
      end
    end

    context "下書き状態で" do
      context "stockが空の場合" do
        let(:ticket) { build(:draft_ticket, :stock => "") }
        
        it "validationに成功すること" do
          should be_valid 
        end
      end 

      context "stockが0の場合" do
        let(:ticket) { build(:draft_ticket, :stock => 0) }
        
        it "validationに失敗すること" do
          should_not be_valid 
        end
      end

      context "stockが999の場合" do
        let(:ticket) { build(:draft_ticket, :stock => 999) }

        it "validationに成功すること" do
          should be_valid 
        end
      end
    end

    context "販売終了状態で" do
      context "stockが0の場合" do
        let(:ticket) { build(:closed_ticket, :stock => 0) }
        it "validationに成功すること" do
          should be_valid 
        end
      end

      context "stockが999の場合" do
        let(:ticket) { build(:closed_ticket, :stock => 999) }
        it "validationに成功すること" do
          should be_valid 
        end
      end
    end

    context "審査中状態で" do
       context "stockが0の場合" do
        let(:ticket) { build(:examining_ticket, :stock => 0) }

        it "validationに失敗すること" do
          should_not be_valid 
        end
      end

      context "stockが999の場合" do
        let(:ticket) { build(:examining_ticket, :stock => 999) }

        it "validationに成功すること" do
          should be_valid 
        end
      end
     
    end
  end

  describe "#examine!" do
    before do
      @ticket = FactoryGirl.create(:draft_ticket)
    end

    it "release_statusが審査中（4)になること" do
      expect {
        @ticket.examine!({:ticket => {:stock => 10}})
      }.should change(@ticket, :release_status).to(4)
    end

    it "引数に渡したハッシュで値が変更されていること" do
      expect {
        @ticket.examine!({:ticket => {:stock => 10}})
      }.should change(@ticket, :stock).to(10)
    end

    it "チケットの変更履歴が保存されること" do
      expect {
        @ticket.examine!({:ticket => {:stock => 10}})
      }.should change(TicketHistory, :count).to(1)
    end
  end

  describe "#open!" do
    let(:ticket) { create(:examining_ticket) }

    it "release_statusが公開中(1)になること" do
      expect {
        ticket.open!
      }.should change(ticket, :release_status).to(1)
    end

    context "published_atがnilであれば" do
      it "published_atに時間がセットされること" do
        ticket.open!
        ticket.published_at.should_not be_nil
      end
    end

    context "published_atが存在すれば" do
      let(:ticket) { create(:examining_ticket, :published_at => Time.now) }

      it "published_atが変わらないこと" do
        expect {
          ticket.open!
        }.should_not change(ticket, :published_at)
      end    
    end

    context "不採用理由が存在する場合" do
      before do 
        @rejection_ticket = FactoryGirl.create(:rejection_ticket, :ticket => ticket) 
      end

      it "不採用理由が削除されること" do
        expect {
          ticket.open!  
        }.should change(RejectionTicket, :count).by(-1)
      end
    end
  end

  describe "reject!" do
    before do
      @ticket = FactoryGirl.create(:examining_ticket)
      @rejection_ticket = FactoryGirl.build(:rejection_ticket)
    end

    it "release_statusが不採用(5)になること" do
      expect {
        @ticket.reject!(@rejection_ticket)
      }.should change(@ticket, :release_status).to(5)
    end

    it "rejection_ticketが保存されること" do
      @ticket.reject!(@rejection_ticket)
      @rejection_ticket.should_not be_new_record
    end
  end

  describe "close!" do
    let(:ticket) { FactoryGirl.create(:opening_ticket) }

    it "release_statusが販売終了になること" do
      expect { 
        ticket.close!
      }.to change(ticket, :release_status).from(1).to(2)
    end

    it "closed_atに販売終了時刻が入ること" do
      ticket.close!
      ticket.closed_at.should_not be_nil 
    end
  end

  describe "#draft?" do
    context "#release_statusが0であれば" do
      it "trueになること" do
        @ticket = FactoryGirl.create(:draft_ticket)
        @ticket.draft?.should be_true 
      end 
    end 

    context "#release_statusが0以外であれば" do
      it "falseになること" do
        @ticket = FactoryGirl.create(:opening_ticket)
        @ticket.draft?.should be_false
      end 
    end 
  end

  describe "#set_release_status" do
    before do
      @ticket = FactoryGirl.create(:draft_ticket)
    end

    context ":draftを指定した時" do
      it "release_statusが0になること" do
        @ticket.set_release_status(:draft)
        @ticket.release_status.should == 0
      end
    end

    context ":openingを指定した時" do
      it "release_statusが1になること" do
        expect { 
          @ticket.set_release_status(:opening)
        }.should change(@ticket, :release_status).from(0).to(1)
      end
    end

    context ":closedを指定した時" do
      it "release_statusが2になること" do
        expect { 
          @ticket.set_release_status(:closed)
        }.should change(@ticket, :release_status).from(0).to(2)
      end
    end

    context ":deletedを指定した時" do
      it "release_statusが3になること" do
        expect { 
          @ticket.set_release_status(:deleted)
        }.should change(@ticket, :release_status).from(0).to(3)
      end
    end
    
    context ":examiningを指定した時" do
      it "release_statusが4になること" do
        expect { 
          @ticket.set_release_status(:examining)
        }.should change(@ticket, :release_status).from(0).to(4)
        
      end
    end

    context ":rejectionを指定した時" do
      it "release_statusが5になること" do
        expect { 
          @ticket.set_release_status(:rejection)
        }.should change(@ticket, :release_status).from(0).to(5)
        
      end
    end

  end

  describe "#opening?" do
    context "#release_statusが1で" do
      context "#stockが1以上であれば" do
        it "trueになること" do
          @ticket = FactoryGirl.create(:opening_ticket)
          @ticket.opening?.should be_true 
        end 
      end

      context "#stockが1以下であれば" do
        it "trueになること" do
          @ticket = FactoryGirl.create(:non_stock_ticket)
          @ticket.stock = 0
          @ticket.opening?.should be_false
        end 
      end
    end 

    context "#release_statusが1以外であれば" do
      it "falseになること" do
        @ticket = FactoryGirl.create(:draft_ticket)
        @ticket.opening?.should be_false
      end 
    end 
  end

  describe "#examining?" do
    context "#release_statusが4であれば" do
      it "trueになること" do
        @ticket = FactoryGirl.create(:examining_ticket)
        @ticket.examining?.should be_true 
      end 
    end 

    context "#release_statusが4以外であれば" do
      it "falseになること" do
        @ticket = FactoryGirl.create(:opening_ticket)
        @ticket.examining?.should be_false
      end 
    end 
  end

  describe "#closed?" do
    context "#release_statusが2であれば" do
      it "trueになること" do
        @ticket = FactoryGirl.create(:closed_ticket)
        @ticket.closed?.should be_true 
      end 
    end 

    context "#release_statusが2以外であれば" do
      it "falseになること" do
        @ticket = FactoryGirl.create(:opening_ticket)
        @ticket.closed?.should be_false
      end 
    end 
  end

  describe "#editable?" do
    context "チケット出品者と引数のuserが同じであり" do
      context "引数のuserがadminであれば" do
        before do
          @user = FactoryGirl.create(:admin_user)
          @ticket = FactoryGirl.create(:opening_ticket, :user => @user)
        end

        it "trueになること" do
          @ticket.editable?(@user).should be_true 
        end 
      end    

      context "引数のuserがadminでなくても" do
        before do
          @user = FactoryGirl.create(:user)
          @ticket = FactoryGirl.create(:opening_ticket, :user => @user)
        end

        it "falseになること" do
          @ticket.editable?(@user).should be_true 
        end 
      end    
    end    
  end

  describe "#deletable?" do
    context "チケットが下書き状態であり" do
      context "チケット出品者と引数のuserが同じでれば" do
        before do
          @user = FactoryGirl.create(:user)
          @ticket = FactoryGirl.create(:draft_ticket, :user => @user)
        end

        it "trueになること" do
          @ticket.deletable?(@user).should be_true 
        end 
      end
      context "チケット出品者と引数のuserが異なり" do
        context "引数のuserがadminであれば" do
          before do
            @user = FactoryGirl.create(:admin_user)
            @ticket = FactoryGirl.create(:draft_ticket)
          end

          it "trueになること" do
            @ticket.deletable?(@user).should be_true
          end
        end
        
        context "引数のuserがadminでなけば" do
          before do
            @user = FactoryGirl.create(:user)
            @ticket = FactoryGirl.create(:draft_ticket)
          end

          it "falseになること" do
            @ticket.deletable?(@user).should be_false 
          end
        end
      end
    end
    context "チケットが下書き状態でなければ" do
      before do
        @user = FactoryGirl.create(:user)
        @ticket = FactoryGirl.create(:opening_ticket, :user => @user)
      end

      it "falseになること" do
        @ticket.deletable?(@user).should be_false
      end 
    end
  end

  describe "#rejection?" do
    context "release_statusが不採用(5)であれば" do
      it "trueになること" do
        ticket = FactoryGirl.create(:ticket) 
        ticket.release_status = 5
        ticket.rejection?.should be_true
      end 
    end  

    context "release_statusが5以外であれば" do
      it "falseになること" do
        ticket = FactoryGirl.create(:opening_ticket) 
        ticket.rejection?.should be_false
      end  
    end
  end

  describe "#reviewd?" do
    before do
      @ticket = FactoryGirl.create(:opening_ticket)
      @user = FactoryGirl.create(:user)
      @review = FactoryGirl.create(:review, :ticket => @ticket, :user => @user)
    end

    context "チケットに対してレビューを書いたことがあれば" do
      it "trueになること" do
        @ticket.reviewd?(@user).should be_true
      end
    end  

    context "チケットに対してレビューを書いたことがなければ" do
      it "falseになること" do
        @ticket.reviewd?(FactoryGirl.create(:user)).should be_false
      end
    end
  end

  describe "#favorited?" do
    let(:user) { FactoryGirl.create(:user) }
    let(:ticket) { FactoryGirl.create(:ticket) }
    subject { ticket.favorited?(user) }

    context "ユーザーがお気に入りしている場合" do
      before { FactoryGirl.create(:favorite, :user => user, :ticket => ticket) }
      it "trueになること" do
        should be_true
      end
    end
    context "ユーザーがお気に入りしていない場合" do
      it "falseになること" do
        should be_false
      end
    end
    context "ユーザーがnilの場合" do
      let(:user) { nil }
      it "falseになること" do
        should be_false
      end
    end
  end

  describe "#create_notification?" do
    before do
      @ticket = FactoryGirl.create(:examining_ticket)
    end

    context "release_statusが変更されていて" do
      context "release_statusが公開中であれば" do
        it "trueになること" do
          @ticket.release_status = 1
          @ticket.create_notification?.should be_true
        end 
      end

      context "release_statusが公開中でなければ" do
        it "falseになること" do
          @ticket.release_status = 2
          @ticket.create_notification?.should be_false 
        end
      end
    end

    context "release_statusが変更されていない場合" do
      it "falseになること" do
        @ticket.create_notification?.should be_false 
      end
    end
  end

  describe "#select_commodity_types" do
    before do
      @ticket = FactoryGirl.build(:ticket)
    end
    it { @ticket.select_commodity_types == [["remote",0],["video",1],["pdf",2]] }
  end

  describe "#set_commodity_type" do
    let(:ticket) { FactoryGirl.build(:ticket) }

    before do
      ticket.set_commodity_type(type)
    end

    context ":remoteを指定すると" do
      let(:type) { :remote }
      it "commodity_typeが0になること" do
        ticket.commodity_type.should == 0
      end
    end

    context ":videoを指定すると" do
      let(:type) { :video }
      it "commodity_typeが2になること" do
        ticket.commodity_type.should == 2
      end
    end

    context ":pdfを指定すると" do
      let(:type) { :pdf }
      it "commodity_typeが1になること" do
        ticket.commodity_type.should == 1
      end
    end
  end

  describe "#video?" do
    subject { ticket.video? }
    let(:ticket) { FactoryGirl.create(:ticket) }

    context "commodity_typeが2であれば" do
      let(:ticket) {
        t = FactoryGirl.create(:ticket)
        t.commodity_type = 2
        t
      }
      it "trueになること" do
        should be_true 
      end
    end 

    context "commodity_typeが0であれば" do
      it "falseになること" do
        should be_false
      end
    end
  end

  describe "#pdf?" do
    subject { ticket.pdf? }
    let(:ticket) { FactoryGirl.create(:ticket) }
    context "commodity_typeが1であれば" do
      let(:ticket) {
        t = FactoryGirl.create(:ticket)
        t.commodity_type = 1
        t
      }

      it "trueになること" do
        should be_true 
      end
    end 

    context "commodity_typeが0であれば" do
      it "falseになること" do
        should be_false
      end
    end
  end

  describe "#pdf_examine!" do
    let(:ticket) { FactoryGirl.create(:draft_ticket) }
    let(:pdf) { FactoryGirl.build(:pdf, :user => nil) }

    it "審査中のステータスに変わること" do
      ticket.pdf_examine!(pdf)
      ticket.reload
      ticket.release_status == Ticket::RELEASE_STATUS["examining"]
    end

    it "PDFが保存されること" do
      ticket.pdf_examine!(pdf)
      pdf.should_not be_new_record
    end
  end

  describe ".search_query" do
    before(:all) { @ticket = FactoryGirl.create(:opening_ticket) }
    let(:query) { @ticket.title }
    subject { Ticket.search_query(query) }
    include_context "database_cleaner"

    context "検索ワードがタイトルにヒットするなら" do
      it "該当チケットがヒットすること" do
        should be_include(@ticket)
      end
    end
    context "検索ワードがチケット詳細にヒットするなら" do
      let(:query) { @ticket.description }
      it "該当チケットがヒットすること" do
        should be_include(@ticket)
      end
    end
    context "検索ワードがタイトル、チケット詳細にヒットしないなら" do
      let(:query) { "tigau" }
      it "該当チケットがヒットすること" do
        should_not be_include(@ticket)
      end
    end
    context "検索ワードに該当するチケットが複数あるなら" do
      before { FactoryGirl.create(:opening_ticket) }
      it "複数ヒットすること" do
        should have_at_least(2).items
      end
    end
  end

  describe ".recent_watched" do
    let(:user) { create(:user) }
    let(:user2) { create(:user) }
    let(:ticket) { create(:opening_ticket) }
    let(:ticket2) { create(:opening_ticket) }
    let(:ticket3) { create(:opening_ticket) }
    let(:session_id) { "hogehoge" }
    let(:session_id2) { "hogehogehogehoge" }
    before do
      create(:page_view, :ticket => ticket, :session_id => session_id, :user_id => nil)
      create(:page_view, :ticket => ticket, :session_id => session_id, :user_id => user.id)
      create(:page_view, :ticket => ticket2, :session_id => session_id2, :user_id => user.id)
    end
    context "userがnilの場合" do
      subject { Ticket.recent_watched(nil, session_id).count }
      it "1件ヒットすること" do
        should == 1
      end
    end
    
    context "userが存在する場合" do
      subject { Ticket.recent_watched(user, session_id).count }
      it "2件ヒットすること" do
        should == 2
      end
    end
  end

  describe "#is_title_not_too_long?" do
    subject { ticket.is_title_not_too_long? }
    let(:ticket) { FactoryGirl.create(:ticket) }
    context "ticketのタイトル長が18未満であれば" do
      it "trueになること" do
        should be_true
      end
    end 

    context "ticketのタイトル長が18以上であれば" do
      let(:ticket) { FactoryGirl.create(:too_long_title_ticket) }
      it "falseなること" do
        should be_false 
      end
    end 
  end

  describe "#is_first_open?" do
    subject { ticket.is_first_open? }
    let(:ticket) { FactoryGirl.create(:draft_ticket) }
    context "初めての出品であれば" do
      before do
        ticket.published_at = Time.now
      end 

      it "trueになること" do
        should be_true
      end
    end 

    context "既に出品済みのチケットであれば" do
      let(:ticket) { FactoryGirl.create(:opening_ticket) }
      before do
        ticket.published_at = Time.now
      end 
      it "falseなること" do
        should be_false 
      end
    end 
  end

  describe "#set_pickup_status" do
    before do
      @ticket = FactoryGirl.create(:opening_ticket)
    end

    context ":commonを指定した時" do
      it "pickup_statusが0になること" do
        @ticket.set_pickup_status(:common)
        @ticket.pickup_status.should == 0
      end
    end

    context ":hotを指定した時" do
      it "pickup_statusが1になること" do
        @ticket.set_pickup_status(:hot)
        @ticket.pickup_status.should == 1
      end
    end

    context ":top_saleを指定した時" do
      it "pickup_statusが2になること" do
        @ticket.set_pickup_status(:top_sale)
        @ticket.pickup_status.should == 2
      end
    end
  end
end
