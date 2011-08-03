require "./game/bootstrap.rb"
Game::Bootstrap.new.execute

puts "Checking for test cases:"
Dir["./test/**/*_test.rb"].each do |testcase|
  puts "\t#{testcase}"
  require testcase
end
puts " "
