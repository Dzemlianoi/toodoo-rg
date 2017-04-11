# frozen_string_literal: true

class Comment < ApplicationRecord
  belongs_to :task
  mount_uploader :attachment, CommentAttachmentUploader

  validates_presence_of :comment_text, :task
  validates_length_of :comment_text, in: 2..200
end
