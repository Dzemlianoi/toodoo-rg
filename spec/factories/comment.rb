FactoryGirl.define do
  factory :comment do
    comment_text { FFaker::LoremUA.words(9) }
    task
  end
end