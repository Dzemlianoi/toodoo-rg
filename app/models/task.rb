# frozen_string_literal: true

class Task < ApplicationRecord
  belongs_to :project
  has_many :comments, dependent: :destroy

  scope :active, -> { where(completed: true) }

  before_validation :set_priority, on: :create
  before_destroy :move_prioritis

  validates_presence_of :title, :priority, :project
  validates_length_of :title, in: 2..40
  validates_numericality_of :priority, only_integer: true, greater_than: 0
  validate :correct_deadline

  default_scope { order('priority ASC') }

  def priority_up
    sided_task = project.tasks.active.where("priority < #{priority.to_i}").last.increment!(:priority)
    self_task = self.decrement!(:priority)
    { sided_task: sided_task, self_task: self_task }
  end

  def priority_down
    sided_task = project.tasks.active.where("priority > #{ priority.to_i + 1 }").first.decrement!(:priority)
    self_task = self.increment!(:priority)
    { sided_task: sided_task, self_task: self_task }
  end

  private

  def set_priority
    self.priority = project.tasks.empty? ? 1 : (project.tasks.last.priority + 1)
  end

  def move_prioritis
    project.tasks.where("priority > #{ priority }").find_each { |task| task.decrement!(:priority) }
  end

  def correct_deadline
    return unless deadline
    errors.add(:deadline, I18n.t('errors.task.deadline')) if deadline.past?
  end
end
