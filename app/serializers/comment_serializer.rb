# frozen_string_literal: true

class CommentSerializer < ActiveModel::Serializer
  attributes :id, :comment_text
end
