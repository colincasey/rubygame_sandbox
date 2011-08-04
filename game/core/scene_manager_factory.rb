require "game/core/entity_factory"
require "game/core/collision_tree"
require "game/core/scene_manager"
require "game/core/collision_node"
require "game/core/collision_tree"
require "game/entities/fox"

include Rubygame
include Rubygame::Events
include Rubygame::EventActions
include Rubygame::EventTriggers

module Game::Core
  
  class SceneManagerFactory
    
    def self.create
      Log.info "Initializing scene manager..."
      
      resolution = [640,480]
      Log.info "Creating screen #{resolution}"
      screen = Screen.new resolution, 0, [Rubygame::HWSURFACE,Rubygame::DOUBLEBUF]
      screen.title = "Sandbox"
      
      fps = 60
      Log.info "Clocking game at #{fps} fps"
      clock = Clock.new
      clock.target_framerate = fps
      clock.enable_tick_events
      
      entity_factory = EntityFactory.new
      
      parent_collision_node = CollisionNode.new Rect.new(0, 0, 640, 480), 5
      collision_tree = CollisionTree.new parent_collision_node
      
      resource_dir = "./../Resource"
      Surface.autoload_dirs << File.join(resource_dir, "img")  
      Sound.autoload_dirs   << File.join(resource_dir, "sfx")
      Music.autoload_dirs   << File.join(resource_dir, "music")
      
      sm = SceneManager.new screen, clock, entity_factory, collision_tree
      
      #test objects
      sm.add "Fox", 100, 100
      
      return sm
    end
    
  end

end