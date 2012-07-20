# encoding: utf-8
require "spec_helper"

describe Notifier do
  let(:sender) { FactoryGirl.create(:user) }
  let(:recipient) { FactoryGirl.create(:user) }
  let(:name) { sender.name }

  shared_examples_for "send mail" do
    it { subject.to.should == [recipient.email] }

    it { subject.subject.should == I18n.t("notifier.#{action}.subject", :name => name) } 
  end

  describe ".followed" do
    let(:action) { "followed" }
    let(:resource) { create(:friendship, :user => sender, :friend => recipient) }
    let(:notification) { create(:friendship_notification, :user => sender, :recipient_user => recipient, :resource_id => resource.id) }

    subject { Notifier.followed(notification) }

    it_should_behave_like "send mail"
  end

  describe ".reviewed" do
    let(:action) { "reviewed" }
    let(:review) { FactoryGirl.create(:review, :ticket => FactoryGirl.create(:ticket), :user => sender) }
    let(:name) { review.ticket.title }
    let(:notification) { create(:review_notification, :user => sender, :recipient_user => recipient, :resource_id => review.id) }

    subject { Notifier.reviewed(notification) }

    it_should_behave_like "send mail"
  end

  describe ".purchased" do
    let(:action) { "purchased" }
    let(:purchase) { FactoryGirl.create(:purchase) }
    let(:sender) { purchase.user }
    let(:recipient) { purchase.ticket.user }
    let(:name) { purchase.ticket.title }
    let(:notification) { create(:purchase_notification, :user => sender, :recipient_user => recipient, :resource_id => purchase.id) }

    before do
      FactoryGirl.create(:exhibitor, :user => recipient)
    end
    subject { Notifier.purchased(notification) }

    it_should_behave_like "send mail"
  end

  describe ".purchase" do
    let(:action) { "purchase" }
    let(:purchase) { FactoryGirl.create(:purchase) }
    let(:sender) { purchase.ticket.user }
    let(:recipient) { purchase.user }
    let(:name) { purchase.ticket.title }
    let(:notification) { create(:purchase_notification, :user => purchase.user, :recipient_user => purchase.ticket.user, :resource_id => purchase.id) }

    subject { Notifier.purchase(notification) }

    it_should_behave_like "send mail" 
  end

  describe ".adopted_as_exhibitor" do
    let(:action) { "adopted_as_exhibitor" }
    let(:recipient) { FactoryGirl.create(:user) }
    let(:notification) { create(:user_notification, :user => sender, :recipient_user => recipient, :resource_id => recipient.id) }

    subject { Notifier.adopted_as_exhibitor(notification) }

    it_should_behave_like "send mail"
  end

  describe ".received_message" do
    let(:action) { "received_message" }
    let(:conversation) { FactoryGirl.create(:conversation) }
    let(:sender) { FactoryGirl.create(:user) }
    let(:recipient) { FactoryGirl.create(:user) }
    let(:message) { FactoryGirl.create(:message, :conversation => conversation, :user => sender, :to_user => recipient)} 
    let(:notification) { create(:message_notification, :user => sender, :recipient_user => recipient, :resource_id => message.id) }


    subject { Notifier.received_message(notification) }

    it_should_behave_like "send mail"
  end


  describe ".commented" do
    let(:action) { "commented" }
    let(:recipient) { FactoryGirl.create(:user) }
    let(:sender) { FactoryGirl.create(:user) }
    let(:note) { FactoryGirl.create(:note, :user => recipient) }
    let(:note_comment) { FactoryGirl.create(:note_comment, :note => note, :user => sender) }
    let(:notification) { create(:note_comment_notification, :user => sender, :recipient_user => recipient, :resource_id => note_comment.id) }
    subject { Notifier.commented(notification) }
    
    it_should_behave_like "send mail"
  end

  describe ".adopted_as_ticket" do
    let(:action) { "adopted_as_ticket" }
    let(:ticket) { FactoryGirl.create(:ticket) }
    let(:recipient) { ticket.user }
    let(:name) { ticket.title }
    let(:notification) { create(:adopt_ticket_notification, :user => sender, :recipient_user => recipient, :resource_id => ticket.id) }

    subject { Notifier.adopted_as_ticket(notification) }

    it_should_behave_like "send mail"
  end

  describe "rejected" do
    let(:action) { "rejected" }
    let(:ticket) { FactoryGirl.create(:ticket) }
    let(:recipient) { ticket.user }
    let(:name) { ticket.title }
    let(:notification) { create(:reject_ticket_notification, :user => sender, :recipient_user => recipient, :resource_id => ticket.id) }

    subject { Notifier.rejected(notification) }

    it_should_behave_like "send mail"
  end

  describe "requested" do
    let(:action) { "requested" }
    let(:sender) { FactoryGirl.create(:user) }
    let(:recipient) { FactoryGirl.create(:user) }
    let(:request_message) { FactoryGirl.create(:request_message, :user => sender, :to_user => recipient) }
    let(:want) { create(:want, :request_message => request_message, :user => sender) }
    let(:notification) { create(:want_notification, :user => sender, :recipient_user => recipient, :resource_id => want.id) }

    subject { Notifier.requested(notification) }

    it_should_behave_like "send mail"
  end
  
  describe ".posted_board" do
    let(:action) { "posted_board" }
    let(:recipient) { FactoryGirl.create(:user) }
    let(:sender) { FactoryGirl.create(:user) }
    let(:note) { FactoryGirl.create(:note, :user => recipient) }
    let(:notification) { create(:note_notification, :user => sender, :recipient_user => recipient, :resource_id => note.id) }
    
    subject { Notifier.posted_board(notification) }
    
    it_should_behave_like "send mail"
  end

  describe ".ticket_commented" do
    let(:action) { "ticket_commented" }
    let(:recipient) { FactoryGirl.create(:user) }
    let(:sender) { FactoryGirl.create(:user) }
    let(:note) { FactoryGirl.create(:note, :user => recipient) }
    let(:notification) { create(:note_notification, :user => sender, :recipient_user => recipient, :resource_id => note.id) }
    
    subject { Notifier.ticket_commented(notification) }
    
    it_should_behave_like "send mail"
  end

  describe ".favorited" do
    let(:action) { "favorited" }
    let(:recipient) { FactoryGirl.create(:user) }
    let(:sender) { FactoryGirl.create(:user) }
    let(:favorite) { FactoryGirl.create(:favorite, :user => recipient) }
    let(:notification) { create(:favorite_notification, :user => sender, :recipient_user => recipient, :resource_id => favorite.id) }
    
    subject { Notifier.favorited(notification) }
    
    it_should_behave_like "send mail"
  end

end
