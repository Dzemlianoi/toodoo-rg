# frozen_string_literal: true

class ProjectSerializer < ActiveModel::Serializer
  attributes :id, :title
  has_many tasks
end
