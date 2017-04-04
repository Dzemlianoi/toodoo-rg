class TaskSerializer < ActiveModel::Serializer
  attributes :id, :title, :deadline, :priorite, :completed
  has_many :comments
end