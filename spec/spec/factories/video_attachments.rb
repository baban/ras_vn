# Read about factories at http://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :video_attachment do
    file File.open(File.join(Rails.root, "spec", "support", "images", "sample_movie.mov"))
  end
end
