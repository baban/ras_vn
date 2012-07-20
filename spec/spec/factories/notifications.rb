# Read about factories at http://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :notification do
    association :user
    association :recipient_user, :factory => :user
  end

  factory :purchase_notification, :parent => :notification, :class => "Notifications::Purchase" do
    type "Notifications::Purchase"
  end

  factory :review_notification, :parent => :notification, :class => "Notifications::Review" do
    type "Notifications::Review"
  end

  factory :user_notification, :parent => :notification, :class => "Notifications::User" do
    type "Notifications::User"
  end

  factory :message_notification, :parent => :notification, :class => "Notifications::Message" do
    type "Notifications::Message"
  end

  factory :adopt_ticket_notification, :parent => :notification, :class => "Notifications::Ticket" do
    type "Notifications::Ticket"
    body "---
:release_status: 1"
  end

  factory :reject_ticket_notification, :parent => :notification, :class => "Notifications::Ticket" do
    type "Notifications::Ticket"
    body "---
:release_status: 5"
  end

  factory :favorite_notification, :parent => :notification, :class => "Notifications::Favorite" do
    type "Notifications::Favorite"
  end

  factory :note_notification, :parent => :notification, :class => "Notifications::Note" do
    type "Notifications::Note"
  end

  factory :note_comment_notification, :parent => :notification, :class => "Notifications::NoteComment" do
    type "Notifications::NoteComment"
  end

  factory :friendship_notification, :parent => :notification, :class => "Notifications::Friendship" do
    type "Notifications::Friendship"
  end

  factory :want_notification, :parent => :notification, :class => "Notifications::Want" do
    type "Notifications::Want"
  end
end
