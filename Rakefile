desc "run the game"
task :run do
  system 'ruby run.rb'  
end

desc "run the tests"
task :test do
  system 'ruby test.rb'
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

