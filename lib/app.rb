require 'sequel'

DB = Sequel.sqlite

class HapaSushiApp < Sinatra::Base
  set :root, 'lib/app'

  get '/' do
    erb :index
  end

  get '/happy' do
    erb :happy
    'happy hour menu'
  end

  get '/lunch' do
    erb :lunch
    'lunch menu'
  end

  get '/dinner' do
    erb :dinner
    'dinner menu'
  end

  get '/gluten' do
    erb :gluten
    'gluten-free menu'
  end

  get '/kids' do
    erb :kids
    'kids menu'
  end

  get '/drinks' do
    erb :drinks
    'drink menu'
  end

  get '/platters' do
    erb :platters
    'our platters'
  end

  get '/to-go' do
    erb :togo
    'to-go menu'
  end

end
