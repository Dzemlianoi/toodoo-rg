class Comment < ApplicationRecord
  belongs_to :task
  belongs_to :user
  validates_presence_of :comment_text, :user, :task
end
