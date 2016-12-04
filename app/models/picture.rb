class Picture
  include Mongoid::Document
  include Mongoid::Timestamps

  mount_uploader :file, ImageUploader
  embedded_in :farm
end
