class Project < ApplicationRecord
  belongs_to :user
  has_many :tasks, dependent: :destroy

  validates_presence_of :title, :user
  validates_length_of :title, in: 2..40
end
