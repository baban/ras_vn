# Read about factories at http://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :ticket do
    association :user
    association :category
    title "hoge"
    price "1000"
    stock 3
    delivery_period 5
    image { fixture_file_upload(Rails.root.to_s + "/spec/support/images/nikujaga.jpg", "image/jpg") }
    description "mogemoge"
    closed_at Time.now

    after_create do |ticket, proxy|
      proxy.image.close
    end
  end

  factory :draft_ticket, :parent => :ticket do
    release_status 0
  end

  factory :examining_ticket, :parent => :ticket do
    release_status 4
  end

  factory :reject_ticket, :parent => :ticket do
    release_status 5
  end

  factory :closed_ticket, :parent => :ticket do
    published_at Time.now
    release_status 2
  end

  factory :opening_ticket, :parent => :ticket do
    release_status 1
    stock 10
    published_at Time.now
    after_create do |ticket, proxy|
      activity = FactoryGirl.create(:ticket_activity, :user => ticket.user)
      FactoryGirl.create(:activity_resource, :activity => activity, :resource_id => ticket.id)
      proxy.image.close
    end
  end

  factory :hot_ticket, :parent => :opening_ticket do
    pickup_status 1 
  end

  factory :top_sale_ticket, :parent => :opening_ticket do
    pickup_status 2 
  end

  factory :non_stock_ticket, :parent => :ticket do
    release_status 1
    stock 0
  end

  factory :too_long_title_ticket, :parent => :ticket do
    title "a" * 18
  end

  factory :pdf_ticket, :parent => :ticket do
    release_status 1 
    stock 10
    published_at Time.now
    commodity_type 1
  end

  factory :video_ticket, :parent => :ticket do
    release_status 1 
    stock 10
    published_at Time.now
    commodity_type 2
  end
end
