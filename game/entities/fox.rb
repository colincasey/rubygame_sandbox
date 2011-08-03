require "./game/core/player_input.rb"
require "./game/core/entity.rb"
require "./game/core/collision_hitbox.rb"
require "./game/core/sprite_sheet.rb"

include Game::Core

module Game::Entites

  class Fox < Entity
    
    attr_reader :hitbox
    
    def initialize(px, py)
      super px, py
      @input = PlayerInput.new
      @sprite = SpriteSheet.new "./resource/img/pic_walk.png", [5, 20, 5, 20], 3, 2, 4, 4
      @hitbox = CollisionHitbox.new @sprite.sprite_rect
      @hitbox.enable_collision
    end
  
    def update(seconds)
      @input.fetch
      move
      handle_collisions
       
      
      if @input.key_pressed?( :down )   
        @sprite.update_row 3
      end
      if @input.key_pressed?( :up )   
        @sprite.update_row 1
      end
      if @input.key_pressed?( :right )   
        @sprite.update_row 2
      end
      if @input.key_pressed?( :left )   
        @sprite.update_row 4
      end
    end
    
    def draw(screen)
      @sprite.animate
      @sprite.draw screen, @px, @py
    end
    
    def move
      x, y = 0,0
      x -= 1 if @input.key_pressed?( :left )
      x += 1 if @input.key_pressed?( :right )
      y -= 1 if @input.key_pressed?( :up ) # up is down in screen coordinates
      y += 1 if @input.key_pressed?( :down )
      if(x != 0 || y != 0)
        @px = @px + x
        @py = @py + y
      end
    end
    
    def handle_collisions
      if @hitbox.colliding? 
        puts "s"
      end
    end
  
  end

end