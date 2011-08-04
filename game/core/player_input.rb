
module Game::Core
  
  class PlayerInput
    include Rubygame
    include Rubygame::Events
    include Rubygame::EventHandler::HasEventHandler
    
    def initialize
      @queue = Rubygame::EventQueue.new
      @queue.enable_new_style_events
      @keys = [] # Keys being pressed
      create_event_hooks
    end
  
    def fetch
      @queue.fetch_sdl_events
      @queue.each { |event| handle( event ) }  
      create_event_hooks     
    end
    
    def create_event_hooks
      hooks = {
        KeyPressed => :key_pressed,
        KeyReleased => :key_released,
        QuitEvent => :close,
        :q => :close,
      }
      make_magic_hooks hooks
    end
    
    def key_pressed( event )
      @keys += [event.key]
    end
   
    def key_released( event )
      @keys -= [event.key]
    end
    
    def close
      throw :quit
    end
    
    def key_pressed?(key)
      @keys.include? key
    end
    
  end

end