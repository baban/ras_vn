# encoding: utf-8
# Read about factories at http://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :campaign do
  end

  factory :review_campaign, :parent => :campaign, :class => "Campaigns::Review" do
    title "QUOカードプレゼントキャンペーン"
    limit_number 1000
    questions ["今回ご購入されたチケットの感想を教えてください。", "Abilieにどんなチケットがあると購入したいと思いますか？", "Abilieのサイトへのご要望やご意見などをお聞かせください。"]
    start_at Time.parse("2012/04/05 15:00:00")
    closed_at Time.parse("2012/04/30 23:59:59")
    entry_closed_at Time.parse("2012/05/07 10:00:00")
    type "Campaigns::Review"
  end
end
