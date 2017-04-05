FactoryGirl.define do
  factory :task do
    title { FFaker::LoremUA.words(3) }
    project

    factory :with_invalid_deadline do
      deadline { DateTime.now }
    end

    factory :with_valid_deadline do
      deadline { DateTime.now + 10.days }
    end
  end
end