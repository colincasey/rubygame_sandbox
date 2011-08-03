module Game::Core

  class GameObject
    attr_reader :px
    attr_reader :py
    attr_reader :gobject_id
    attr_reader :surface
    
    @@gobject_id_counter = 0
    
    def initialize(px, py)
      @px = px
      @py = py
      @@gobject_id_counter = @@gobject_id_counter + 1
      @gobject_id = @@gobject_id_counter
    end
    
    def update  
      #implement in sub class  
    end
    
    def draw(screen)
      #implement in sub class
    end
    
  end

end