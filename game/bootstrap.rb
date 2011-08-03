require "rubygame"

include Rubygame
include Rubygame::Events
include Rubygame::EventActions
include Rubygame::EventTriggers

module Game
  
  class Bootstrap
    
    def execute
      require "./game/core/log.rb"
      Game::Core::Log.configure
      configure_resource_autoload
    end
    
    def configure_resource_autoload
      resource_dir = "./../Resource"
      Surface.autoload_dirs << File.join(resource_dir, "img")  
      Sound.autoload_dirs   << File.join(resource_dir, "sfx")
      Music.autoload_dirs   << File.join(resource_dir, "music")
    end
    
  end
  
end