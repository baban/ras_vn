# Read about factories at http://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :activity do
  end

  factory :ticket_activity, :parent => :activity do
    type "Activities::Ticket"
    public_flag true
  end

  factory :friendship_activity, :parent => :activity do
    type "Activities::Friendship"
    public_flag false
  end

  factory :note_activity, :parent => :activity do
    type "Activities::Note"
    public_flag true
  end

  factory :note_comment_activity, :parent => :activity do
    type "Activities::NoteComment"
    public_flag true
  end

  factory :review_activity, :parent => :activity do
    type "Activities::Review"
    public_flag true
  end

  factory :unvisible_review_activity, :parent => :review_activity do
    visible_flag false
  end

  factory :purchase_activity, :parent => :activity do
    type "Activities::Purchase"
    public_flag false
  end
end
