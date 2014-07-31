require 'sequel'

environment = ENV['RUBY_ENV'] || 'development'
DB = Sequel.sqlite("db/hapa_#{environment}")

require 'app/modules/path_builder'
require 'app/models/menu'
require 'app/models/section'
require 'app/models/item'
require 'app/helpers/menu_helper'
require 'app/helpers/link_helper'
require 'app/helpers/html_helper'
require 'app/models/location'
require 'app/models/photo'
require 'app/models/happy_hour'
require 'app/services/mail_validator'
require 'app/services/mailer'

class HapaSushiApp < Sinatra::Base
  set :root, 'lib/app'
  set :session_secret, ENV['SESSION_SECRET'] ||= 'secret'
  set :method_override, true
  set :session_secret, ENV['SESSION_SECRET'] ||= 'secret'

  helpers MenuHelper, LinkHelper, HTMLHelper

  enable :sessions
<<<<<<< HEAD
  use Rack::Flash
=======

  def protected!
    unless session[:admin]
      redirect '/admin/login'
    end
  end
>>>>>>> Finishes CMS

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

  get '/make-a-reservation' do
    @locations = Location.all
    erb :make_a_reservation
  end

  get '/catering' do
    erb :catering
  end

  get '/contact' do
    erb :contact
  end

  post '/contact' do
    validator = MailValidator.new(params)
    if validator.valid?
      flash.now[:success] = true
      Mailer.mail_from_params(params)
      Mailer.mail(
                  from: 'no-reply@hapasushi.com',
                    to: params['email'],
               subject: '(Copy) Your Contact Submission',
                  body: "#{params[:contactName]} wrote:\n\n#{params[:comments]}"
                 ) if params[:sendCopy]
      erb :contact
    else
      flash.now[:error] = validator.errors
      erb :contact
    end

  get '/admin/login' do
    erb :admin_login, layout: :admin_layout
  end

  post '/admin/login' do
    target_password = ENV['ADMIN_PASS'] || 'secret'
    if params[:password] = target_password
      session[:admin] = true
      redirect '/admin'
    else
      redirect '/admin/login'
    end
  end

  get '/admin' do
    protected!
    erb :admin, layout: :admin_layout
  end
  
  get '/admin/locations' do
    protected!
    @locations = Location.all
    erb :admin_location_index, layout: :admin_layout
  end
  
  post '/admin/locations' do
    protected!
    Location.create_with_path(params[:location])
    redirect '/admin/locations'
  end
  
  get '/admin/locations/:id' do |id|
    protected!
    @location = Location.find(id: id)
    erb :admin_location_edit, layout: :admin_layout
  end

  delete '/admin/locations/:id' do |id|
    protected!
    Location.find(id: id).delete
    redirect '/admin/locations'
  end
  
  put '/admin/locations/:id' do |id|
    protected!
    Location.find(id: id).update_with_path(params[:location])
    redirect "/admin/locations/#{id}"
  end
  
  post '/admin/locations/:location_id/photos' do |location_id|
    protected!
    location = Location.find(id: location_id)
    location.add_photo(params[:photo])
    redirect "/admin/locations/#{location_id}"
  end
  
  delete '/admin/locations/:location_id/photos/:photo_id' do |location_id, photo_id|
    protected!
    Photo.find(id: photo_id).delete
    redirect "/admin/locations/#{location_id}"
  end

  get '/admin/menus' do
    protected!
    erb :admin_menu_index, layout: :admin_layout
  end

  post '/admin/menus' do
    protected!
    Menu.create_with_path(params[:menu])
    redirect '/admin/menus'
  end

  get '/admin/menus/:id' do |id|
    protected!
    @menu = Menu.find(id: id)
    erb :admin_menu_edit, layout: :admin_layout
  end

  delete '/admin/menus/:id' do |id|
    protected!
    Menu.find(id: id).delete
    redirect '/admin/menus'
  end

  put '/admin/menus/:id' do |id|
    protected!
    Menu.find(id: id).update_with_path(params[:menu])
    redirect "/admin/menus/#{id}"
  end

  post '/admin/menus/:menu_id/sections' do |menu_id|
    protected!
    menu = Menu.find(id: menu_id)
    menu.add_section(params[:section])
    redirect "/admin/menus/#{menu_id}"
  end

  delete '/admin/menus/:menu_id/sections/:section_id' do |menu_id, section_id|
    protected!
    Section.find(id: section_id).delete
    redirect "/admin/menus/#{menu_id}"
  end

  get '/admin/menus/:menu_id/sections/:section_id' do |menu_id, section_id|
    protected!
    @menu_id = menu_id
    @section = Section.find(id: section_id)
    erb :admin_section_edit, layout: :admin_layout
  end

  put '/admin/menus/:menu_id/sections/:section_id' do |menu_id, section_id|
    protected!
    Section.find(id: section_id).update(params[:section])
    redirect "/admin/menus/#{menu_id}/sections/#{section_id}"
  end

  post '/admin/menus/:menu_id/sections/:section_id/items' do |menu_id, section_id|
    protected!
    section = Section.find(id: section_id)
    section.add_item(params[:item])
    redirect "/admin/menus/#{menu_id}/sections/#{section_id}"
  end

  delete '/admin/menus/:menu_id/sections/:section_id/items/:item_id' do |menu_id, section_id, item_id|
    protected!
    Item.find(id: item_id).delete
    redirect "/admin/menus/#{menu_id}/sections/#{section_id}"
  end

  get '/admin/menus/:menu_id/sections/:section_id/items/:item_id' do |menu_id, section_id, item_id|
    protected!
    @menu_id, @section_id = menu_id, section_id
    @item = Item.find(id: item_id)
    erb :admin_item_edit, layout: :admin_layout
  end

  put '/admin/menus/:menu_id/sections/:section_id/items/:item_id' do |menu_id, section_id, item_id|
    protected!
    Item.find(id: item_id).update(params[:item])
    redirect "/admin/menus/#{menu_id}/sections/#{section_id}"
  end
end
