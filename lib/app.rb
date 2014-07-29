require 'sequel'

DB = Sequel.sqlite

class HapaSushiApp < Sinatra::Base
  set :root, 'lib/app'

  get '/' do
    erb :index
  end

  get '/about-hapa' do
    erb :about
  end
end
