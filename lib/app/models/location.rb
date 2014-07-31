class Location < Sequel::Model
  include PathBuilder

  one_to_many :photos
  one_to_many :happy_hours

  def primary_image
    photos.detect(&:primary?)
  end
  
  def add_photo(params)
    photo = Photo.new(params)
    photo.image = params[:file]
    photo.location_id = id
    photo.save
  end
end
