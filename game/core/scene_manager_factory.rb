require "rubygame"
require "./game/core/entity_factory.rb"
require "./game/core/collision_tree.rb"
require "./game/core/scene_manager.rb"
require "./game/core/collision_node.rb"
require "./game/core/collision_tree.rb"
require "./game/entities/fox.rb"

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
      
      sm = SceneManager.new screen, clock, entity_factory, collision_tree
      
      #test objects
      sm.add "Fox", 100, 100
      #sm.add "Planet", 300, 300
      
      return sm
    end
    
  end

end