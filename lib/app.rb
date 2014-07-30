require 'sequel'

environment = ENV['RUBY_ENV'] || 'development'
DB = Sequel.sqlite("db/hapa_#{environment}")

require 'app/models/menu'
require 'app/models/section'
require 'app/models/item'
require 'app/helpers/menu_helper'
require 'app/helpers/link_helper'
require 'app/models/location'
require 'app/models/location'
require 'app/models/photo'
require 'app/models/happy_hour'

class HapaSushiApp < Sinatra::Base
  set :root, 'lib/app'

  helpers MenuHelper, LinkHelper

  not_found do
    erb :not_found
  end

  get '/' do
    erb :index
  end

  get '/menu/:path' do |path|
    menu = Menu.find(path: path)
    if menu
      erb :menu, locals: { menu: menu }
    else
      raise Sinatra::NotFound
    end
  end

  get '/about-hapa' do
    erb :about
  end

  get '/catering' do
    erb :catering
  end
end
