require_relative '../test_helper'

describe 'User can visit the contact page' do
  include Rack::Test::Methods
  include Capybara::DSL
  include DatabaseHelpers

  def setup
    Mail.defaults do
      delivery_method :test
    end

    clear_db
  end

  def teardown
    Mail::TestMailer.deliveries.clear
    clear_db
  end

  describe 'Visiting the contact page' do
    it 'the user sees a form' do
      visit '/'
      click_link 'Contact'

      assert_equal 200, page.status_code
      assert page.has_css?('form#contactForm')
    end

    it 'the user can fill out the form and send an email' do
      visit '/'
      click_link 'Contact'

      within('form#contactForm') do
        fill_in 'Name', with: 'Joe Test'
        fill_in 'Email', with: 'joe@test.com'
        fill_in 'Message', with: 'This is my email message.'
        click_button 'Submit'
      end

      assert_equal 200, page.status_code
      assert_equal 1, Mail::TestMailer.deliveries.count
    end
    
    it 'the user can receive a copy of his email' do
      visit '/'
      click_link 'Contact'

      within('form#contactForm') do
        fill_in 'Name', with: 'Joe Test'
        fill_in 'Email', with: 'joe@test.com'
        fill_in 'Message', with: 'This is my email message.'
        check 'sendCopy'
        click_button 'Submit'
      end

      assert_equal 200, page.status_code
      assert_equal 2, Mail::TestMailer.deliveries.count
    end

    it 'sees an error with invalid data' do
      visit '/contact'
      
      within('form#contactForm') do
        fill_in 'Name', with: ''
        fill_in 'Email', with: ''
        fill_in 'Message', with: ''
        click_button 'Submit'
      end

      assert_equal 200, page.status_code
      assert page.has_content?('You must enter your name.')
      assert page.has_content?('You must enter a valid email address.')
      assert page.has_content?('You must enter a message.')
    end
  end
end
