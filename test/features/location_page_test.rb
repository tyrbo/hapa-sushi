require_relative '../test_helper'

describe 'User can visit a location page' do
  include Rack::Test::Methods
  include Capybara::DSL
  include DatabaseHelpers

  def setup
    clear_db
  end

  def teardown
    clear_db
  end

  describe 'a user visiting the main location page' do
    it 'sees a location page title' do
      Location.create(path: 'location', title: 'LoDo')
      visit '/location'

      assert_equal 200, page.status_code
      assert page.has_content?('LoDo')
    end

    it 'sees all location page titles' do
      Location.create(path: 'location', title: 'LoDo')
      Location.create(path: 'location', title: 'Boulder')
      visit '/location'

      assert_equal 200, page.status_code
      assert page.has_content?('LoDo')
      assert page.has_content?('Boulder')
    end

    it 'should see any photos that exist' do
      location = Location.create(path: 'location', title: 'LoDo')
      location.add_photo(path: 'photo1.jpg', primary: true)

      visit '/location'
      assert_equal 200, page.status_code

      images = page.all('img')
      assert images.any? { |x| x['src'].include?('photo1.jpg') }
    end
  end

  describe 'a user visiting the boulder location page' do
    it 'should be able to see title' do
      Location.create(path: 'boulder-pearl-street', title: 'Boulder-Pearl Street')
      visit '/location/boulder-pearl-street'

      assert_equal 200, page.status_code
      assert page.has_content?('Boulder-Pearl Street')
    end

    it 'should see location specific picture' do
      location = Location.create(path: 'boulder-pearl-street')
      location.add_photo(path: 'sushi.png')

      visit '/location/boulder-pearl-street'
      assert_equal 200, page.status_code

      images = page.all('img')
      assert images.any? { |x| x['src'].include?('sushi.png') }
    end

    it 'should see multiple pictures' do
      location = Location.create(path: 'boulder-pearl-street')
      location.add_photo(path: 'sushi.png')
      location.add_photo(path: 'nigiri.png')
      location.add_photo(path: 'sake.png')

      visit '/location/boulder-pearl-street'
      assert_equal 200, page.status_code

      images = page.all('img')
      assert images.any? { |x| x['src'].include?('sushi.png') }
      assert images.any? { |x| x['src'].include?('sake.png') }
      assert images.any? { |x| x['src'].include?('nigiri.png') }
    end

    it 'should see happy hour menu' do
      location = Location.create(path: 'boulder-pearl-street')
      location.add_happy_hour(title: 'Early Bird', description: 'Hot Sake, Edamame, Rolls')

      visit '/location/boulder-pearl-street'
      assert_equal 200, page.status_code

      assert page.has_content?('Edamame')
    end

    it 'should see all happy hour menus' do
      location = Location.create(path: 'boulder-pearl-street')
      location.add_happy_hour(title: 'Early Bird', description: 'Hot Sake, Edamame, Rolls')
      location.add_happy_hour(title: 'Night Owl', description: 'California Rolls')

      visit '/location/boulder-pearl-street'
      assert_equal 200, page.status_code

      assert page.has_content?('Edamame')
      assert page.has_content?('California Rolls')  
    end

  end

  describe 'a user visiting a non-existent page' do
    it 'should see a 404 not found page' do
      visit '/location/notvalid'

      assert_equal 404, page.status_code
    end
  end
end
