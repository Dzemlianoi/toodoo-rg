class CommentAttachmentUploader < CarrierWave::Uploader::Base
  include Cloudinary::CarrierWave
end
