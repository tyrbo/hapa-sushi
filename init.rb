require 'sequel'

Dir.mkdir('db') unless Dir.exists?('db')

environment = ENV['RUBY_ENV'] || 'development'
file = "db/hapa_#{environment}"

DB = Sequel.sqlite(file)

DB.drop_table(:menus) if DB.table_exists?(:menus)
DB.create_table(:menus) do
  primary_key :id
  String :path
  String :title
end

DB.drop_table(:sections) if DB.table_exists?(:sections)
DB.create_table(:sections) do
  primary_key :id
  String :title
  String :alignment
  Integer :menu_id
end

DB.drop_table(:items) if DB.table_exists?(:items)
DB.create_table(:items) do
  primary_key :id
  String :title
  String :description
  String :price
  Integer :section_id
end
