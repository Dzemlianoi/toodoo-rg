# frozen_string_literal: true

class CommentAttachmentUploader < CarrierWave::Uploader::Base
  include Cloudinary::CarrierWave
end
