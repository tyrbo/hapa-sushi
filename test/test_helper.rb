require 'minitest/autorun'
require 'minitest/pride'
require 'minitest/spec'
require 'rack/test'
require 'capybara'

require 'bundler'
Bundler.require
require 'app'

Capybara.app = HapaSushiApp
