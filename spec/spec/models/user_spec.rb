# -*- coding: utf-8 -*-
require 'spec_helper'

describe User do
  describe "validation" do
    context "emailが正しい値の場合" do
      it "validationを通ること" do
        FactoryGirl.build(:user).should be_valid 
      end
    end
    context "emailが不正な値の場合" do
      it "validationに引っかかること" do
        FactoryGirl.build(:invalid_email_user).should_not be_valid 
      end
    end
  end

  describe "#own?" do
    before do
      @user1 = FactoryGirl.create(:user)
      @user2 = FactoryGirl.create(:user)
    end

    context "引数のuserが同じであれば" do
      it "trueになること" do
        @user1.own?(@user1).should be_true
      end
    end 

    context "引数のuserが異なれば" do
      it "falseになること" do
        @user1.own?(@user2).should be_false
      end
    end 
  end

  describe "owner?" do
    let(:user) { FactoryGirl.create(:exhibited_user) }
    subject { user.owner?(ticket) }

    context "チケットの出品者が自分であれば" do
      let(:ticket) { FactoryGirl.create(:opening_ticket, :user => user) }
      it "trueになること" do
        should be_true 
      end
    end  

    context "チケットの出品者と異なれば" do
      let(:ticket) { FactoryGirl.create(:opening_ticket) }
      it "falseになること" do
        should be_false 
      end
    end
  end

  describe "#followed?" do
    before do
      @user1 = FactoryGirl.create(:user)
      @user2 = FactoryGirl.create(:user)
    end

    context "応援済みであれば" do
      before do
        Friendship.create(:user => @user1, :friend => @user2)
      end

      it "trueになること" do
        @user1.followed?(@user2).should be_true  
      end
    end  

    context "未応援であれば" do
      it "falseになること" do
        @user1.followed?(@user2).should be_false
      end
    end
  end

  describe "#follow" do
    before do 
      @user1 = FactoryGirl.create(:user)
      @user2 = FactoryGirl.create(:user)
    end

    it "Friendshipが作成されること" do
      lambda {
        @user1.follow(@user2) 
      }.should change(Friendship, :count).by(1)
    end

    it "@user1のfriends_countが+1されること" do
      lambda {
        @user1.follow(@user2) 
        @user1.reload
      }.should change(@user1, :friends_count).by(1)
    end

    it "@user2のfollowers_countが+1されること" do
      lambda {
        @user1.follow(@user2) 
        @user1.reload
        @user2.reload
      }.should change(@user2, :followers_count).by(1)
    end
  end

  describe "#unfollow" do
    before do 
      @user1 = FactoryGirl.create(:user)
      @user2 = FactoryGirl.create(:user)
      @user1.follow(@user2)
    end

    it "Friendshipが削除されること" do
      lambda {
        @user1.unfollow(@user2)
      }.should change(Friendship, :count).by(-1)
    end

    it "@user1のfriends_countが-1されること" do
      lambda {
        @user1.unfollow(@user2)
        @user1.reload
      }.should change(@user1, :friends_count).by(-1)
    end

    it "@user2のfollowers_countが-1されること" do
      lambda {
        @user1.unfollow(@user2)
        @user2.reload
      }.should change(@user2, :followers_count).by(-1)
    end
  end

  describe "#admin?" do
    let(:user) { FactoryGirl.create(:user) }
    subject { user.admin? }
    context "admin_typeが0であれば" do
      it "falseになること" do
        should be_false
      end
    end

    context "admin_typeが1であれば" do
      let(:user) { FactoryGirl.create(:admin_user) }
      it "trueになること" do
        should be_true
      end
    end

    context "admin_typeが2であれば" do
      let(:user) { FactoryGirl.create(:user_communication_user) }
      it "trueになること" do
        should be_true
      end
    end

    context "admin_typeが3であれば" do
      let(:user) { FactoryGirl.create(:financial_affairs_user) }
      it "trueになること" do
        should be_true
      end
    end
  end

  describe "#premium?" do
    let(:user) { FactoryGirl.create(:user) }
    subject { user.premium? }
    context "premium_statusが0であれば" do
      it "falseになること" do
        should be_false
      end
    end

    context "premium_statusが1であれば" do
      let(:user) { FactoryGirl.create(:semi_vip_user) }
      it "trueになること" do
        should be_true
      end
    end

    context "premium_statusが2であれば" do
      let(:user) { FactoryGirl.create(:vip_user) }
      it "trueになること" do
        should be_true
      end
    end
  end

  describe "#change_admin!(type)" do
    let(:user) { FactoryGirl.create(:user) }
    subject { user.admin_type }
    it "引数にguestを与えればadmin_typeが0になること" do
      user.change_admin!("guest")
      should == 0
    end

    it "引数にadminを与えればadmin_typeが1になること" do
      user.change_admin!("abilie")
      should == 1
    end

    it "引数にuser_communicationを与えればadmin_typeが2になること" do
      user.change_admin!("user_communication")
      should == 2
    end

    it "引数にfinancial_affairsを与えればadmin_typeが2になること" do
      user.change_admin!("financial_affairs")
      should == 3
    end

    it "引数が想定外(hogehogeなど)の場合、admin_typeが0になること" do
      user.change_admin!("hogehoge")
      should == 0
    end
  end

  describe "#change_premium!(type)" do
    let(:user) { FactoryGirl.create(:user) }
    subject { user.premium_status }

    it "引数にnormalを与えればpremium_statusが0になること" do
      user.change_premium!("normal")
      should == 0
    end

    it "引数にsemi_vipを与えればpremium_statusが1になること" do
      user.change_premium!("semi_vip")
      should == 1
    end

    it "引数にvipを与えればpremium_statusが2になること" do
      user.change_premium!("vip")
      should == 2
    end

    it "引数が想定外（hogehogeなど）であれば、premium_statusが0になること" do
      user.change_premium!("hogehoge")
      should == 0
    end
  end

  describe "#purchase!" do
    let(:ticket_owner) { FactoryGirl.create(:user) }
    let(:ticket) { FactoryGirl.create(:opening_ticket, :user => ticket_owner) }
    let(:user) { FactoryGirl.create(:user) }

    context "チケットが公開中でなければ" do
      let(:ticket) { FactoryGirl.create(:draft_ticket) }

      it "falseが返ること" do
        user.purchase!(ticket).should be_false
      end
    end 

    context "チケット購入可能な場合" do
      before do
        exhibitor = FactoryGirl.create(:exhibitor, :user => ticket_owner)
        user.stub(:purchasable?).and_return(true)
      end

      it "purchasesが保存されること" do
        expect {
          user.purchase!(ticket) 
        }.should change(Purchase, :count).by(1)
      end

      describe "アフィリエイト経由の時" do
        it "affiliate_idが保存されること" do
          affiliate = create(:affiliate)
          user.purchase!(ticket, nil, nil, affiliate.id) 
          Purchase.last.affiliate_id.should == affiliate.id
        end
      end

      it "在庫(stock)が1減ること" do
        expect {
          user.purchase!(ticket)
          ticket.reload
        }.should change(ticket, :stock).by(-1)
      end

      it "最終購入日が更新されること" do
          user.purchase!(ticket)
          ticket.reload
          ticket.last_purchased_at.should == Purchase.last.created_at
      end

      it "ticketのpurchases_countが+1されること" do
        expect {
          user.purchase!(ticket)
          ticket.reload
        }.to change(ticket, :purchases_count).by(1)
      end

      it "Activities::Purchaseが保存されること" do
        expect {
          user.purchase!(ticket)
        }.should change(Activities::Purchase, :count).by(1)
      end

      it "売り上げ(Bills::Income)が増える" do
        expect {
          user.purchase!(ticket)
          ticket.reload
        }.should change(Bills::Income, :count).by(1)
      end
      it "支払い履歴(Bills::Payment)が増える" do
        expect {
          user.purchase!(ticket)
          ticket.reload
        }.should change(Bills::Payment, :count).by(1)
      end

      context "在庫が0になった場合" do
        let(:ticket) { FactoryGirl.create(:opening_ticket, :user => ticket_owner, :stock => 1) }

        it "チケットが販売終了になること" do
          expect {
            user.purchase!(ticket)
            ticket.reload
          }.to change(ticket, :release_status).from(1).to(2)
        end
      end

      it "Conversationが作成されること" do
        expect {
          user.purchase!(ticket)
        }.should change(Conversation, :count).by(1)
      end

      it "ConversationMemberが作成されること" do
        expect {
          user.purchase!(ticket)
        }.should change(ConversationMember, :count).by(2)
      end

      it "指定したtransaction_idと同じtmp_purchaseが削除されること" do
        tmp_purchase = create(:tmp_purchase)
        user.purchase!(ticket, tmp_purchase.transaction_id)
        TmpPurchase.find_by_id(tmp_purchase.id).should be_nil
      end
    end
  end

  describe "#purchasable?" do
    let(:user) { FactoryGirl.create(:exhibited_user) }
    let(:ticket) { FactoryGirl.create(:opening_ticket) }
    subject { user.purchasable?(ticket) }
    context "チケットが公開中でなければ" do
      let(:ticket) { FactoryGirl.create(:draft_ticket)}
      it "falseが返る事" do
        should be_false
      end 
    end  

    context "チケットの所有者が自分であれば" do
      let(:ticket) { FactoryGirl.create(:opening_ticket, :user => user) }
      it "falseが返ること" do
        should be_false
      end 
    end

    context "購入済みであれば" do
      before do
        FactoryGirl.create(:purchase, :ticket => ticket, :user => user)
      end
      it "falseが返ること" do
        pending "複数回購入が可能になったのでpending"  
        should be_false
      end 
    end
    
    context "購入可能であれば" do
      it "trueが返ること" do
        should be_true
      end
    end
  end

  describe "#purchased?" do
    pending "あとで"  
  end

  describe "#board!" do
    let(:user) { FactoryGirl.create(:user) }
    let(:note) { {:note => FactoryGirl.attributes_for(:note) }}

      it "noteが作成されること" do
        expect { user.board!(note) }.to change(Note, :count).by(1) 
      end

    context "reply_toが存在する" do
      let(:reply_user) { FactoryGirl.create(:user) }
      let(:note) {{
        :note => FactoryGirl.attributes_for(:note),
        :reply_to => reply_user.url_name
      }}
      it "in_reply_to_userが関連付けされること" do
        target =  user.board!(note)
        target.in_reply_to_user.should == reply_user 
      end
    end    
    context "ticket_idが存在する" do
      let(:ticket_owner) { FactoryGirl.create(:user) }
      let(:ticket) { FactoryGirl.create(:opening_ticket, :user => ticket_owner) }
      let(:note) {{
        :note => FactoryGirl.attributes_for(:note),
        :ticket_id => ticket.id
      }} 
      it "ticketが関連付けされること" do
        target =  user.board!(note)
        target.ticket.should == ticket 
      end
    end    
  end

  describe "#sendable_message?" do
    before do
      @user = FactoryGirl.create(:user)
      @user2 = FactoryGirl.create(:user)
    end

    context "引数がない場合に" do
      it "ConversationMemberに会話できるユーザがいない場合falseが返ること" do
        @user.sendable_message?.should be_false
      end

      it "ConversationMemberに会話できるユーザがいる場合trueが返ること" do
        FactoryGirl.create(:conversation_member, :user => @user)

        @user.sendable_message?.should be_true
      end
    end

    context "引数がある場合に" do
      it "会話できるユーザがいない場合falseが返ること" do
        @user.sendable_message?(@user2).should be_false
      end

      it "会話できるユーザがいる場合trueが返ること" do
        @conversation = FactoryGirl.create(:conversation)
        FactoryGirl.create(:conversation_member, :user => @user, :conversation => @conversation)
        FactoryGirl.create(:conversation_member, :user => @user2, :conversation => @conversation)

        @user.sendable_message?(@user2).should be_true
      end
    end
  end

  describe "#conversation(user)" do
    pending "あとで"  
  end

  describe "#timeline" do
    before do
      @user = FactoryGirl.create(:user)
      @user2 = FactoryGirl.create(:user)
      FactoryGirl.create(:friendship, :user => @user, :friend => @user2)
      ticket = FactoryGirl.create(:opening_ticket, :user => @user)
      FactoryGirl.create(:review, :ticket => ticket, :user => @user)
      FactoryGirl.create(:purchase, :ticket => ticket, :user => @user2)
      note = FactoryGirl.create(:note, :user => @user2)
      FactoryGirl.create(:note_comment, :note => note, :user => @user)
    end
    it "Activityが6件あること" do
      @user.timeline.should have(6).items 
    end  
  end

  describe "#create_verify_url" do
    let(:user) { FactoryGirl.create(:user) }

    subject { user.create_verify_url }

    it "nilでないこと" do
      should_not be_nil  
    end

    it "verify用のURLが返ること" do
      should match(/http:\/\/www.example.com\/users\/verify_email\?auth_code=.+/)
    end
  end

  describe "#verify" do
    let(:user) { FactoryGirl.create(:unverified_email_user) }
    let(:auth_code) { "hoge" }

    context "idとredisに保存されているidが同じ場合" do
      before do
        @redis = Abilie::Redis.connection
        @redis.set "user:verify:#{auth_code}", user.id
      end

      it "verify_email_flagがtrueになること" do
        expect {
          user.verify auth_code
        }.should change(user, :verify_email_flag).from(false).to(true)
      end

      it "redisから値が削除されていること" do
        user.verify auth_code
        @redis.get("user:verify:#{auth_code}").should be_nil
      end
    end 

    context "idとredisに保存されているidが異なる場合" do
      before do
        @redis = Abilie::Redis.connection
        @redis.set "user:verify:#{auth_code}", "nooooo"
      end

      it "falseが返ること" do
        user.verify(auth_code).should be_false 
      end
    end 
  end

  describe "#has_bank_account?" do
    context "口座情報が登録済みであれば" do
      before do
        @user = FactoryGirl.create(:user)
        FactoryGirl.create(:exhibitor, :user => @user)
      end
      it "trueが返る事" do
        @user.has_bank_account?.should be_true
      end 
    end  

    context "口座情報が未登録であれば" do
      before do
        @user = FactoryGirl.create(:exhibited_user)
        FactoryGirl.create(:unregistered_bank_exhibitor, :user => @user)
      end
      it "falseが返る事" do
        @user.has_bank_account?.should be_false
      end 
    end
  end

  describe "#correct_password?" do
    let(:user) { FactoryGirl.create(:user) } 
    subject { user.correct_password?(password) }

    context "現在のパスワードと同じであれば" do
      let(:password) { user.password }
      it "trueになること" do
        should be_true 
      end 
    end 

    context "現在のパスワードと異なれば" do
      let(:password) { "tigau" }
      it "falseになること" do
        should be_false 
      end
    end
  end

  describe "#secure_signined?" do
    let(:user) { FactoryGirl.create(:user) }
    subject { user.secure_signined? }
    context "過去にセキュアなページにログインしていない場合" do
      it "falseになること" do
        should be_false 
      end
    end 

    context "過去にセキュアなページにログインしていて" do
      context "24時間以内にログインしていれば" do
        let(:user) { FactoryGirl.create(:user, :secure_signined_at => Time.now) }
        it "trueになること" do
          should be_true 
        end 
      end 

      context "24時間より前にログインしていれば" do
        let(:user) { FactoryGirl.create(:user, :secure_signined_at => Time.now.yesterday) }
        it "falseになること" do
          should be_false 
        end
      end
    end
  end

  describe "#increase_notifications_count" do
    context "notifications_count が5未満であれば" do
      before do
        @user = FactoryGirl.create(:user)
      end
      it "notifications_countが1増えること" do
        expect {
          @user.increase_notifications_count
        }.should change(@user, :notifications_count).by(1)
      end 
    end  
    context "notifications_count が5以上であれば" do
      before do
        @user = FactoryGirl.create(:notificated_user)
      end
      it "notifications_countは変わらないこと" do
        expect {
          @user.increase_notifications_count
        }.should change(@user, :notifications_count).by(0)
      end 
    end  
  end

  describe "#reset_notifications_count" do
    context "notifications_count が1以上であれば" do
      before do
        @user = FactoryGirl.create(:notificated_user)
      end
      it "notifications_countが0になること" do
        expect {
          @user.reset_notifications_count
        }.should change(@user, :notifications_count).to(0)
      end 
    end  
    context "notifications_count が0であれば" do
      before do
        @user = FactoryGirl.create(:user)
      end
      it "notifications_countは変わらないこと" do
        expect {
          @user.reset_notifications_count
        }.should change(@user, :notifications_count).by(0)
      end 
    end  
  end
  describe "#sex_choices" do
    before do
      @user = FactoryGirl.build(:user)
    end
    it "引数が\"male\"の時、1 が返ること" do
      @user.sex_choices("male").should == 1 
    end
    it "引数が\"female\"の時、2 が返ること" do
      @user.sex_choices("female").should == 2 
    end
    it "引数が\"hogehoge\"(想定外)の時、1 が返ること" do
      @user.sex_choices("hoge").should == 1 
    end
  end

  describe "#get_sex" do
    before do
      @male_user = FactoryGirl.build(:user)
      @female_user = FactoryGirl.build(:user, :sex => 2)
    end
    context "男性の出品者の場合" do
      it "性別の表示が男になっていること" do 
        @male_user.get_sex == "男"
      end
    end
    context "女性の出品者の場合" do
      it "性別の表示が女になっていること" do 
        @female_user.get_sex == "女"
      end
    end
  end

  describe "#withdraw!" do
    before do
      @user = FactoryGirl.create(:user)
      @user.withdraw!
      @user.reload
    end
    it "退会フラグがtrueになっていること" do
      @user.delete_flag.should be_true
    end

    it "メール配信希望フラグがfalseになっていること" do
      @user.subscribe_flag.should be_false
    end
  end

  describe "#sendable_request?" do
    let(:user) { FactoryGirl.create(:user) }

    subject { user.sendable_request? }
    describe "フォローしている人がいない場合" do
      it "falseになること" do
        should be_false 
      end 
    end

    describe "フォローしている人がいて" do
      before do
        FactoryGirl.create(:friendship, :user => user, :friend => to_user)
      end

      context "リクエストを受け付けていれば" do
        let(:to_user) { FactoryGirl.create(:user) }
        it "trueになること" do
          should be_true 
        end 
      end 

      context "リクエストを受け付けていなければ" do
        let(:to_user) { FactoryGirl.create(:user, :refuse_request_flag => 1) }
        it "falseになること" do
          should be_false 
        end
      end
    end
  end

  describe "#reviewable?" do
    let(:user) { FactoryGirl.create(:user) }
    let(:ticket) { FactoryGirl.create(:ticket) }
    subject { user.reviewable?(ticket) }

    context "ユーザーとチケットの作者が同じ場合" do
      let(:ticket) { FactoryGirl.create(:ticket, :user => user) }
      it "falseになること" do
        should be_false    
      end 
    end 

    context "ユーザーとチケットの作者が異なり" do
      context "レビューをすでに書いていた場合" do
        before do
          FactoryGirl.create(:review, :user => user, :ticket => ticket)
        end

        it "falseになること" do
          should be_false    
        end 
      end

      context "レビューを書いたことがなく" do
        context "購入済みの場合" do
          before do
            FactoryGirl.create(:purchase, :user => user, :ticket => ticket)
          end

          it "trueになること" do
            should be_true
          end 
        end

        context "購入していない場合" do
          it "falseになること" do
            should be_false    
          end
        end
      end
    end
  end

  describe ".init_with_tmp_user" do
    let(:tmp_user) { FactoryGirl.create(:tmp_user) }
    subject { User.init_with_tmp_user(tmp_user) }

    it "userのインスタンスが返ること" do
      should be_an_instance_of(User) 
    end

    context "url_nameに.が含まれていた場合" do
      let(:tmp_user) { FactoryGirl.create(:tmp_user) }
      it ".が削除されていること" do
        subject.url_name.should_not include("\.")
      end
    end
  end

  describe ".perform(user_id)" do
    before(:all) do
      @user1 = FactoryGirl.create(:user)
      user2 = FactoryGirl.create(:user)

      FactoryGirl.create(:friendship, :user => @user1, :friend => user2)
      FactoryGirl.create(:friendship, :user => user2, :friend => @user1)
      3.times do
        FactoryGirl.create(:note, :user => @user1)
      end
      note = FactoryGirl.create(:note, :user => @user1)
      FactoryGirl.create(:note_comment, :user => @user1, :note => note)
      @delete_note_comment = FactoryGirl.create(:note_comment, :user => user2, :note => note)
      @delete_note_comment_activity = Activity.last
      ticket = FactoryGirl.create(:opening_ticket, :user => @user1)
      FactoryGirl.create(:message_notification, :user => user2, :recipient_user => @user1)
      FactoryGirl.create(:review, :user => @user1, :ticket => ticket)
      FactoryGirl.create(:report, :user => @user1)
      FactoryGirl.create(:service, :user => @user1)
      @request_message = create(:request_message, :user => @user1, :to_user => user2)
      create(:want, :user => @user1)
      @want = create(:want, :request_message => @request_message, :user => user2)
      create(:opening_ticket, :request_message => @request_message)

      @activity_ids = Activity.where(:user_id => @user1).select(:id)
      User.perform(@user1.id)
    end
    include_context "database_cleaner"

    it "アクティビティの情報が削除されていること" do
      Activity.where("user_id" => @user1).should == [] 
    end
    it "アクティビティリソースの情報が削除されていること" do
      ActivityResource.where("activity_id" => @activity_ids).should == []
    end
    it "ボードの情報が削除されていること" do
      Note.where("user_id" => @user1).should == []
    end
    it "ボードのコメント情報が削除されていること" do
      NoteComment.where("user_id" => @user1).should == []
    end
    it "お知らせの情報が削除されていること" do
      Notification.where("user_id" => @user1).should == []
      Notification.where("recipient_user_id" => @user1).should == []
    end
    it "フォローの情報が削除されていること" do
      Friendship.where("user_id" => @user1).should == []
    end
    it "被フォローの情報が削除されていること" do
      Friendship.where("friend_id" => @user1).should == []
    end
    it "統計の情報が削除されていること" do
      Report.where("user_id" => @user1).should == []
    end
    it "ログイン情報が削除されていること" do
      Service.where("user_id" => @user1).should == []
    end
    it "退会したユーザーのチケットは削除されない" do
      Ticket.where("user_id" => @user1).should_not == []
    end
    it "退会したユーザーのレビューは削除されない" do
      Review.where("user_id" => @user1).should_not == []
    end
    it "退会したユーザーのボードのコメントが削除されること" do
      NoteComment.find_by_id(@delete_note_comment.id).should be_nil
    end

    it "退会したユーザーのボードににコメントしていたアクティビティが削除されること" do
      Activity.find_by_id(@delete_note_comment_activity.id).should be_nil       
    end

    it "公開中のチケットが無いこと" do
      Ticket.where(:user_id => @user1.id).where(:release_status => Ticket::RELEASE_STATUS["open"]).should be_empty
    end

    it "販売終了ののチケットがあること" do
      Ticket.where(:user_id => @user1.id).where(:release_status => Ticket::RELEASE_STATUS["closed"]).should have_at_least(1).items
    end

    it "リクエストが削除されること" do
      RequestMessage.where(:user_id => @user1.id).should be_empty
    end

    it "リクエストに答えたチケットが無いこと" do
      Ticket.where(:request_message_id => @request_message.id).should be_empty
    end

    it "リクエストに紐付く欲しいが削除されること" do
      Want.where(:request_message_id => @request_message.id).should be_empty  
    end

    it "ほしいが削除されること" do
      Want.where(:user_id => @user1.id).should be_empty
    end

    it "ほしいのお知らせが削除されること" do
      Notifications::Want.where(:resource_id => @want.id).should be_empty
    end

    it "退会したユーザーのリクエストに欲しいしたアクティビティが削除されること" do
      Activities::Want.joins(:activity_resource).where("activity_resources.resource_id IN (?)", @want.id).should be_empty
    end
  end

  describe "#mail_receivable?" do
    let(:user) { build(:user) }
    subject { user.mail_receivable? }

    context "退会済みであれば" do
      let(:user) { build(:deleted_user) }
      it { should be_false }
    end

    context "退会して無くて" do
      context "メール認証済みであれば" do
        it { should be_true }
      end 

      context "メール認証できてなければ" do
        let(:user) { build(:unverified_email_user) }
        it { should be_false }
      end
    end
  end

  describe "#name" do
    subject { user.name }
    
    context "作成前の削除ユーザーの場合" do
      let(:user) { build(:deleted_user) } 

      it "インスタンスの値が返ること" do
        should == user.send(:read_attribute, :name) 
      end
    end

    context "削除ユーザーであれば" do
      let(:user) { create(:deleted_user) }
      it "空であること " do
        should be_empty      
      end
    end 
  end

  describe "#description" do
    subject { user.description }
    context "作成前の削除ユーザーの場合" do
      let(:user) { build(:deleted_user) } 

      it "インスタンスの値が返ること" do
        should == user.send(:read_attribute, :description)
      end
    end

    context "削除ユーザーであれば" do
      let(:user) { create(:deleted_user) }

      it "空であること " do
        should be_empty     
      end
    end 
  end

  describe "#url_name" do
    subject { user.url_name }

    context "作成前の削除ユーザーの場合" do
      let(:user) { build(:deleted_user) } 

      it "インスタンスの値が返ること" do
        should == user.send(:read_attribute, :url_name) 
      end
    end
    context "削除ユーザーであれば" do
      let(:user) { create(:deleted_user) }

      it "notfoundであること " do
        should == "notfound" 
      end
    end 
  end

  describe "#image" do
    subject { user.image }

    context "作成前の削除ユーザーの場合" do
      let(:user) { build(:deleted_user) } 

      it "インスタンスの値が返ること" do
        should be_an_instance_of ProfileUploader
      end
    end

    context "削除ユーザーであれば" do
      let(:user) { create(:deleted_user) }

      it "空であること " do
        should be_an_instance_of NotfoundUploader   
      end
    end 
  end

  describe "#age" do
    it "年齢が返ること" do
      @user = FactoryGirl.create(:born_in_now_user)
      @user.age.should == 0
    end
  end
end
