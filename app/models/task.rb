class Task < ApplicationRecord
  belongs_to :project
  has_many :comments, dependent: :destroy

  before_validation :set_priorite, on: :create
  before_destroy :move_priorites

  validates_presence_of :title, :priorite, :project
  validates_length_of :title, in: 2..40
  validates_numericality_of :priorite , only_integer: true, greater_than: 0
  validate :correct_deadline

  default_scope { order('priorite ASC') }

  private

  def set_priorite
    self.priorite = project.tasks.empty? ? 1 : (project.tasks.last.priorite + 1)
  end

  def move_priorites
    project.tasks.where("priorite > #{priorite}").find_each { |task| task.decrement!(:priorite) }
  end

  def correct_deadline
    return unless deadline
    errors.add(:deadline, I18n.t('errors.task.deadline')) if self.deadline.past?
  end
end
