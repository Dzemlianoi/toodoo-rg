RSpec.describe Task, type: :model do
  context 'fields' do
    subject { create :task, project: create(:project) }

    it { is_expected.to belong_to(:project) }
    it { is_expected.to have_many(:comments).dependent(:destroy) }
    it { is_expected.to validate_presence_of(:title) }
    it { is_expected.to validate_presence_of(:priorite) }
    it { is_expected.to validate_presence_of(:project) }
    it { is_expected.to validate_length_of(:title).is_at_least 2 }
    it { is_expected.to validate_length_of(:title).is_at_most 40 }
    it { is_expected.to validate_numericality_of(:priorite).only_integer }
    it { is_expected.to validate_numericality_of(:priorite).is_greater_than 0 }
  end

  context 'priorite setting' do
    let!(:project) { create :project }
    let!(:task_one) { create :task, project: project }
    let!(:task_two) { create :task, project: project }
    let!(:task_three) { create :task, project: project }

    it 'priorite should add 1 after each task creation' do
      expect(task_one.priorite).to be_equal(1)
      expect(task_two.priorite).to be_equal(2)
    end

    it 'should change all priorites which are lower than it' do
      task_one.destroy
      task_two.reload
      task_three.reload
      expect(task_two.priorite).to be_equal(1)
      expect(task_three.priorite).to be_equal(2)
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
