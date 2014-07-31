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
  end

  describe 'a user visiting the boulder location page' do
    it 'should be able to see title' do
      Location.create(path: 'boulder-pearl-street', title: 'Boulder-Pearl Street', delivery: '', reservations: '')
      visit '/location/boulder-pearl-street'

      assert_equal 200, page.status_code
      assert page.has_content?('Boulder-Pearl Street')
    end
  end

  describe 'a user visiting a non-existent page' do
    it 'should see a 404 not found page' do
      visit '/location/notvalid'

      assert_equal 404, page.status_code
    end
  end
end
