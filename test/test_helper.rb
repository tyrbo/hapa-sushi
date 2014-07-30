require 'minitest/autorun'
require 'minitest/pride'
require 'minitest/spec'
require 'rack/test'
require 'capybara'

require 'bundler'
Bundler.require
require 'app'

require_relative 'helpers/database_helpers'

Capybara.app = HapaSushiApp
