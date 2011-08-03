module Game::Core
  
  class EntityEvent
    
    attr_accessor :name
    attr_accessor :seconds
    
    def initialize(name, seconds)
      @name = name
      @seconds = seconds
    end
    
    def cool_down(seconds_passed)
      @seconds = @seconds - seconds_passed
    end
    
    def is_finished
      @seconds < 0
    end
    
  end

end