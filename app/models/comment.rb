class Comment < ApplicationRecord
  belongs_to :task
  mount_uploader :avatar, CommentAttachmentUploader

  validates_presence_of :comment_text, :task
  validates_length_of :comment_text, in: 2..200
end
