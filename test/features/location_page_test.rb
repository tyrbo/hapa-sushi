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
    it 'sees a location page link' do
      Location.create(path: 'location', title: 'LoDo')
      visit '/location'

      assert_equal 200, page.status_code
      assert page.has_content?('LoDo')
    end
  end

  describe 'a user visiting the boulder location page' do
    it 'should be able to see title' do
      Location.create(path: 'boulder-pearl-street', title: 'Boulder-Pearl Street')
      visit '/location/boulder-pearl-street'

      assert_equal 200, page.status_code
      assert page.has_content?('Boulder-Pearl Street')
    end
  end

  describe 'a user visiting the boulder location page' do
    it 'should be able to see title' do
      Location.create(path: 'lodo', title: 'LoDo')
      visit '/location/lodo'

      assert_equal 200, page.status_code
      assert page.has_content?('LoDo')
    end
  end

  describe 'a user visiting the cherry creek location page' do
    it 'should be able to see title' do
      Location.create(path: 'cherry-creek', title: 'Cherry Creek')
      visit '/location/cherry-creek'

      assert_equal 200, page.status_code
      assert page.has_content?('Cherry Creek')
    end
  end

  describe 'a user visiting the landmark location page' do
    it 'should be able to see title' do
      Location.create(path: 'landmark-at-greenwood-village', title: 'Landmark at Greenwood Village')
      visit '/location/landmark-at-greenwood-village'

      assert_equal 200, page.status_code
      assert page.has_content?('Landmark at Greenwood Village')
    end
  end

  describe 'a user visiting a non-existent page' do
    it 'should see a 404 not found page' do
      visit '/location/notvalid'
      
      assert_equal 404, page.status_code
    end
  end
end
