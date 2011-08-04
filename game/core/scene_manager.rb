require "game/core/script_manager"

module Game::Core
  
  class SceneManager
    
    def initialize(screen, clock, entity_factory, collision_tree)
      @screen = screen
      @clock = clock
      @entities = Hash.new
      @entity_factory = entity_factory
      @collision_tree = collision_tree
      @seconds = 0
    end
    
    def tick
      @seconds = @clock.tick.seconds
      update
      draw
    end
    
    def update
      @collision_tree.update
      @entities.each do |id,e| 
        e.cool_down_events @seconds
        e.update @seconds
      end  
    end
    
    def draw
      @screen.fill(:black)
      @entities.each { |id,e| e.draw @screen }
      @screen.flip 
    end
    
    def add(name, px, py)
      entity = @entity_factory.create name, px, py
      @entities[entity.gobject_id] = entity
      @collision_tree.objects << entity
    end
      
end

end