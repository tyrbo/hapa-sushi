require_relative '../test_helper'

describe Location do
  include DatabaseHelpers

  def setup
    clear_db
  end

  def teardown
    clear_db
  end

  describe '#primary_image' do
    it 'returns the primary image if one is available' do
      location = Location.create
      location.add_photo(path: 'primary.jpg', primary: true)

      assert_equal 'primary.jpg', location.primary_image.path
    end
  end
end
