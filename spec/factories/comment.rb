# frozen_string_literal: true

FactoryGirl.define do
  factory :comment do
    comment_text { FFaker::LoremUA.words(9) }
    task

    factory :comment_with_task do
      task { create :task_with_project }
    end
  end
end
