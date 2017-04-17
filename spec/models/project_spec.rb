# frozen_string_literal: true

RSpec.describe Project, type: :model do
  context 'fields' do
    it { is_expected.to belong_to(:user) }
    it { is_expected.to have_many(:tasks).dependent(:destroy) }
    it { is_expected.to validate_presence_of(:user) }
    it { is_expected.to validate_length_of(:title).is_at_least 2 }
    it { is_expected.to validate_length_of(:title).is_at_most 40 }
  end
end
