require "game/core/game_object"

module Game::Core

  class Entity < GameObject
    
    attr_reader :entity_id
     
    def initialize(px, py)
      super px, py
      @events = []
    end
  
    def update(seconds)
      #implement in sub class 
    end

    def cool_down_events(seconds_passed)
      @events.each do |event|
        event.cool_down seconds_passed
      end
      @events.delete_if {|e| e.is_finished}
    end
    
  end

end