class Location < Sequel::Model
  one_to_many :photos
  one_to_many :happy_hours

  def primary_image
    photos.detect { |x| x.primary == true } ||
      Photo.new(path: 'default.jpg', alt: 'No image available.', primary: true)
  end
end
