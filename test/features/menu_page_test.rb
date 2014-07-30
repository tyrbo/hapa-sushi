require_relative '../test_helper'

describe 'User can visit a menu' do
  include Rack::Test::Methods
  include Capybara::DSL
  include DatabaseHelpers

  def setup
    clear_db
  end

  def teardown
    clear_db
  end

  describe 'a user visiting an existing menu page' do
    it 'see the name of the menu' do
      Menu.create(path: 'test', title: 'Test Menu')
      visit '/menu/test'

      assert_equal 200, page.status_code
      assert page.has_content?('Test Menu')
    end

    it 'should see any menu sections that exist' do
      menu = Menu.create(path: 'test', title: 'Test Menu')
      menu.add_section(title: 'Test Section', alignment: 'left')

      visit '/menu/test'
      assert_equal 200, page.status_code
      assert page.has_content?('Test Section')
    end

    it 'should see any menu items that exist' do
      menu = Menu.create(path: 'test', title: 'Test Menu')
      section = menu.add_section(title: 'Test Section', alignment: 'left')
      section.add_item(title: 'California Roll', description: 'mmm good!', price: '$10')

      visit '/menu/test'
      assert_equal 200, page.status_code
      assert page.has_content?('California Roll')
      assert page.has_content?('mmm good!')
      assert page.has_content?('$10')
    end
  end

  describe 'a user visiting a non-existent page' do
    it 'should see a 404 not found page' do
      visit '/menu/notvalid'
      assert_equal 404, page.status_code
    end
  end
end
