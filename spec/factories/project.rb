FactoryGirl.define do
  factory :project do
    title { FFaker::LoremUA.words(2) }
    user

    factory :project_with_user do
      user { create :user }
    end
  end
end