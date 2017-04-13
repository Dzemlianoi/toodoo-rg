# frozen_string_literal: true

class Project < ApplicationRecord
  before_validation :init_with_title, if: :new_record?

  belongs_to :user
  has_many :tasks, dependent: :destroy

  validates_presence_of :title, :user
  validates_length_of :title, in: 2..40

  DEFAULT_TITLE = 'New task'

  private

  def init_with_title
    self.title = DEFAULT_TITLE
  end
end
