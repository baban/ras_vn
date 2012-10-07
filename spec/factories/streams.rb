# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :stream, :class => 'Streams' do
    user_id 1
    stream_type 1
    title "MyString"
    option_data "MyText"
  end
end
