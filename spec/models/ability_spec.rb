require 'cancan/matchers'

describe 'abilities' do
  subject(:ability){ Ability.new(user) }
  let(:user) { nil }

  context 'when touching another user stuff' do
    it { is_expected.not_to be_able_to(:manage, create(:project_with_user)) }
    it { is_expected.not_to be_able_to(:manage, create(:task_with_project)) }
    it { is_expected.not_to be_able_to(:manage, create(:comment_with_task)) }
  end


  context 'when not authorized' do
    it { is_expected.not_to be_able_to(:manage, create(:project)) }
    it { is_expected.not_to be_able_to(:manage, create(:task)) }
    it { is_expected.not_to be_able_to(:manage, create(:comment)) }
  end

  context 'when is authorized' do
    let(:user) { create(:user) }
    let(:project) { create(:project, user_id: user.id) }
    let(:task) { create(:task, project_id: project.id) }
    let(:comment) { create(:comment, task_id: task.id) }

    it { is_expected.to be_able_to(:manage,  project) }
    it { is_expected.to be_able_to(:manage, task) }
    it { is_expected.to be_able_to(:manage, comment) }
  end

end
