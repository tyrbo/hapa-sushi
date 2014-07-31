require 'app/uploaders/image_uploader'

class Photo < Sequel::Model
  mount_uploader :image, ImageUploader

  def primary?
    primary == true
  end
end
