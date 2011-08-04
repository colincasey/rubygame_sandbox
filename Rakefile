require 'rake/testtask'

desc "run the game"
task :run do
  require File.dirname(__FILE__) + "/game/main"
  Game.run 
end

desc "run the tests"
Rake::TestTask.new do |t|  
  base_dir = File.expand_path(File.dirname(__FILE__))
  test_dir = File.join(base_dir, 'test')
  t.libs << [base_dir, test_dir]
  t.test_files = FileList["#{test_dir}/**/*_test.rb"]
  t.verbose = true
end

namespace :dependencies do
  desc "install dependencies"
  task :install do
    puts 
    system 'bundle install'
    puts 
    system 'ruby install.rb'
  end
end

