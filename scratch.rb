def actor(properties)
  
  
  act =  properties[properties.keys[0]]
  
  act[:sprite_sheet].each do |k,v|
    puts k
  end

end


class ScriptManager
  
  attr_reader :actors
  
  def initialize
    @actors = Hash.new
  end
  
  def def_actor(properties)
    actors[properties.keys[0].to_s] = properties[properties.keys[0]]
  end
  
end

sm = ScriptManager.new

sm.instance_eval File.open("script.rb").read
puts sm.actors["fox"]


  



