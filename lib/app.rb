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
require 'app/services/mail_validator'
require 'app/services/mailer'

class HapaSushiApp < Sinatra::Base
  set :root, 'lib/app'
  set :session_secret, ENV['SESSION_SECRET'] ||= 'secret'

  helpers MenuHelper, LinkHelper

  enable :sessions
  use Rack::Flash

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
  end
end
