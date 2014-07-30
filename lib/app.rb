require 'sequel'

environment = ENV['RUBY_ENV'] || 'development'
DB = Sequel.sqlite("db/hapa_#{environment}")

require 'app/models/menu'
require 'app/models/section'
require 'app/models/item'
require 'app/models/location'
require 'app/models/photo'
require 'app/models/happy_hour'

class HapaSushiApp < Sinatra::Base
  set :root, 'lib/app'

  not_found do
    erb '404'
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

  get '/location' do
    erb :locations, locals: { locations: Location.all }
  end

  get '/location/:path' do |path|
    location = Location.find(path: path)
    if location
      erb :location, locals: { location: location }
    else
      raise Sinatra::NotFound
    end
  end

  get '/about-hapa' do
    erb :about
  end
end
