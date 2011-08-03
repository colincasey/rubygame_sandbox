module Game::Core

  class TextBox
    attr_accessor :x, :y
    
    def initialize(x, y, text)
      @x = x
      @y = y
      @text = Text.new(@x+5, @y+5, text, 16)
      @width = @text.width + 10
      @height = @text.height + 10
      @surface = Rubygame::Surface.new([@width, @height])
      @background_color = [0, 0, 255]
      super(@x, @y, @surface)
    end
    
    def update
      draw(surface)
    end
    
    def draw(screen)
      @surface.fill(@background_color)
      @surface.blit(screen, [@x, @y], @surface.make_rect)
      @text.draw(screen)
    end
    
  end

end