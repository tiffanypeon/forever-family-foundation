class AttachedFile < ActiveRecord::Base
  belongs_to :attachable, polymorphic: true

  has_attached_file :attachment,
    :styles => { :thumb => "200x200>" },
    storage: :s3,
    bucket: 'fff_attached_files',
    s3_credentials: {
      access_key_id: ENV['S3_KEY'],
      secret_access_key: ENV['S3_SECRET']
    }

  attr_accessible :attachment, :kind

  before_post_process :image?

  SUPPORTED_IMAGE_FORMATS = ["image/jpeg", "image/png", "image/gif", "image/bmp"]
  SUPPORTED_IMAGES_REGEX = Regexp.new('\A(' + SUPPORTED_IMAGE_FORMATS.join('|') + ')\Z')

  def image?
    (attachment_content_type =~ SUPPORTED_IMAGES_REGEX).present?
  end

end
