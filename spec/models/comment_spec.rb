RSpec.describe Comment, type: :model do
  context 'fields' do
    it { is_expected.to belong_to(:task) }
    it { is_expected.to validate_presence_of(:comment_text) }
    it { is_expected.to validate_presence_of(:task) }
    it { is_expected.to validate_length_of(:comment_text).is_at_least 2 }
    it { is_expected.to validate_length_of(:comment_text).is_at_most 200 }
  end
end