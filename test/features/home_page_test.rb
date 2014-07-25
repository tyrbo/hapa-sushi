require_relative '../test_helper'

describe 'User can visit the homepage' do
  include Rack::Test::Methods
  include Capybara::DSL

  describe 'a user visiting the home page' do
    it 'see the proper page title' do
      title = 'Hapa Sushi | Sushi Grill | Sake Bar | Colorado'

      visit '/'
      assert page.has_title?(title)
    end
  end
end
