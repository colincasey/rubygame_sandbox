require "./game/core/entity.rb"

include Game::Core

module Game::Entites

  class Planet < Entity
    
    def initialize(px, py, w, h)
      super px, py, w, h
      @image = Resources.load :surface, "planet"
      @rect = @image.make_rect
      @angle = 2*Math::PI * rand
    end
    
    def update(seconds)
      move seconds
    end
    
    def move(seconds)
      @angle = ( @angle + 2*Math::PI / 4 * seconds) % ( 2*Math::PI)
      direction = [Math.sin(@angle), Math.cos(@angle)]
      if(direction[0] != 0 || direction[1] != 0)
        @x = @x + direction[0]
        @y = @y + direction[1] 
        @rect.center = [@x, @y]
      end
    end
      
  end

end