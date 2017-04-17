# frozen_string_literal: true

RSpec.describe Task, type: :model do
  context 'fields' do
    subject { create :task, project: create(:project) }

    it { is_expected.to belong_to(:project) }
    it { is_expected.to have_many(:comments).dependent(:destroy) }
    it { is_expected.to validate_presence_of(:title) }
    it { is_expected.to validate_presence_of(:priority) }
    it { is_expected.to validate_presence_of(:project) }
    it { is_expected.to validate_length_of(:title).is_at_least 2 }
    it { is_expected.to validate_length_of(:title).is_at_most 39 }
    it { is_expected.to validate_numericality_of(:priority).only_integer }
    it { is_expected.to validate_numericality_of(:priority).is_greater_than 0 }
  end

  context 'priority setting' do
    let!(:project) { create :project }
    let!(:task_one) { create :task, project: project }
    let!(:task_two) { create :task, project: project }
    let!(:task_three) { create :task, project: project }

    it 'priority should add 1 after each task creation' do
      expect(task_one.priority).to be_equal(1)
      expect(task_two.priority).to be_equal(2)
    end

    it 'should change all priorities which are lower than it' do
      task_one.destroy
      task_two.reload
      task_three.reload
      expect(task_two.priority).to be_equal(1)
      expect(task_three.priority).to be_equal(2)
    end
  end

  context 'deadline' do
    it 'correct' do
      task = build :with_invalid_deadline
      task.valid?
      expect(task.errors[:deadline].first).to eq(I18n.t('errors.task.deadline'))
    end

    it 'incorrect' do
      task = build :with_valid_deadline
      task.valid?
      expect(task.errors[:deadline]).to be_empty
    end
  end
end
