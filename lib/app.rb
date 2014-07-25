require 'sequel'

DB = Sequel.sqlite

class HapaSushiApp < Sinatra::Base
  def initialize
    super
  end

  get '*' do
    puts DB
    page = request.path_info
  end
end
