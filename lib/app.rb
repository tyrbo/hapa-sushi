require 'sequel'

environment = ENV['RUBY_ENV'] || 'development'
DB = Sequel.sqlite("db/hapa_#{environment}")

require 'app/models/menu'
require 'app/models/section'
require 'app/models/item'
require 'app/helpers/menu_helper'
require 'app/helpers/link_helper'
require 'app/models/location'
require 'app/models/photo'
require 'app/models/happy_hour'

class HapaSushiApp < Sinatra::Base
  set :root, 'lib/app'
  set :method_override, true

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

  get '/catering' do
    erb :catering
  end

  get '/admin' do
    erb :admin, layout: :admin_layout
  end

  get '/admin/menus' do
    erb :admin_menu_index, layout: :admin_layout
  end

  post '/admin/menus' do
    Menu.create(params[:menu])
    redirect '/admin/menus'
  end

  get '/admin/menus/:id' do |id|
    @menu = Menu.find(id: id)
    erb :admin_menu_edit, layout: :admin_layout
  end

  delete '/admin/menus/:id' do |id|
    Menu.find(id: id).delete
    redirect '/admin/menus'
  end
end
