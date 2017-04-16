# frozen_string_literal: true

class CommentSerializer < ActiveModel::Serializer
  attributes :id, :comment_text, :attachment_url, :attachment_name

  def attachment_url
    object.attachment.url
  end

  def attachment_name
    object.attachment.filename
  end
end
