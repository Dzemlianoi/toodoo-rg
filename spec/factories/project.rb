FactoryGirl.define do
  factory :project do
    title { FFaker::LoremUA.words(2) }
    user
  end
end