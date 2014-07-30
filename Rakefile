require 'rake/testtask'

Rake::TestTask.new do |t|
  ENV['RUBY_ENV'] = 'test'
  t.pattern = 'test/**/*_test.rb'
end

task default: :test
