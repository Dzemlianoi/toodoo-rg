# frozen_string_literal: true

class CommentSerializer < ActiveModel::Serializer
  attributes :id, :comment_text, :attachment_url

  def attachment_url
    object.attachment.url || object.attachment.metadata['url']
  end
end
