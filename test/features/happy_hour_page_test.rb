require_relative '../test_helper'

class HappyHourPageTest <Minitest::Test

  describe 'User can visit the happy hour page' do
    include Rack::Test::Methods
    include Capybara::DSL
  end

  describe 'a user visiting the happy hour page' do
    it 'see the proper menu title' do
      h1.class = "menu-title"

      visit '/'
      assert page.has_content?(h1.class)
    end
  end
end
