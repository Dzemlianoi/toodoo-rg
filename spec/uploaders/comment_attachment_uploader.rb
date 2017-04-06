require 'carrierwave/test/matchers'

describe CommentAttachmentUploader do
  let(:file) { fixture_file_upload('/attachments/test_attach.jpg') }
  let(:comment) { create :comment_with_task }
  let(:uploader) { CommentAttachmentUploader.new(comment, :attachment) }

  before do
    CommentAttachmentUploader.enable_processing = true
    File.open(file) { |f| uploader.store!(f) }
  end

  after do
    CommentAttachmentUploader.enable_processing = false
    uploader.remove!
  end

  context 'upload success' do
    it 'added to comment' do
      expect(uploader.metadata['url']).to be_present
    end
  end
end