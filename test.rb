module Game
end
require "./game/core/log.rb"


puts "Checking for test cases:"
Dir["./test/**/*_test.rb"].each do |testcase|
  puts "\t#{testcase}"
  require testcase
end
puts " "
