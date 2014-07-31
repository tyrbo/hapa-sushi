class ImageUploader < CarrierWave::Uploader::Base
  include CarrierWave::MiniMagick

  storage :file

  def store_dir
    "lib/app/public/images/uploads"
  end

  version :location_index do
    process resize_to_fill: [440, 400]
  end
  
  version :location_primary do
    process resize_to_fill: [600, 350]
  end

  version :thumb do
    process resize_to_fill: [145, 90]
  end
end
