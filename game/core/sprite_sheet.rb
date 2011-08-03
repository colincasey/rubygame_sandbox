require "rubygame"
include Rubygame


module Game::Core

  class SpriteSheet
    
    attr_reader :sheet
    attr_reader :row_pos
    attr_reader :col_pos
    attr_reader :frame_timings
    attr_reader :sprite
    attr_reader :sprite_rect
    attr_reader :frame_time_counter
    attr_reader :columns
    attr_reader :rows
    
    def initialize(surface_name, frame_timings, row_pos, col_pos, frames_per_row, frames_per_col)
      
      @sheet = Rubygame::Surface.load(surface_name)
      @frame_timings = frame_timings
      @row_pos = row_pos
      @col_pos = col_pos
      
      col_w = @sheet.w / frames_per_col
      row_h = @sheet.h / frames_per_row
      
      @rows = create_cell_coords frames_per_row, row_h
      @columns = create_cell_coords frames_per_col, col_w
      
      @sprite = Rubygame::Surface.new([col_w, row_h])
      @sprite_rect = Rubygame::Rect.new(columns[col_pos], @rows[row_pos], col_w, row_h)
      @sprite_rect.centerx = @columns[col_pos]
      @sprite_rect.centery = @rows[row_pos]
      
      reset_anim
    end
    
    def update_row(row_pos)
      return if @row_pos == row_pos
      @sprite_rect.centery = @rows[row_pos]
      @row_pos = row_pos
    end
    
    def animate
      @frame_time_counter += 1
      if @frame_time_counter >= @frame_timings[@col_pos-1]
        @col_pos = 0 if @columns[@col_pos+1] == nil
        @col_pos += 1
        @sprite_rect.centerx = @columns[@col_pos]
        @frame_time_counter = 0
      end
      @sheet.blit(@sprite, [0, 0], @sprite_rect)
    end
    
    def reset_anim
      @col_pos = 1
      @sprite_rect.centerx = @columns[@col_pos]
      @frame_time_counter = 0
    end
    
    def draw(screen, x, y)
      @sheet.blit(screen, [x-@sprite.w/2, y-@sprite.h/2], @sprite_rect)
    end
    
    private
    
    def create_cell_coords(count, cell_size)
      index = 1
      items = [nil]
      count.times do
        items << (index * cell_size) - (cell_size / 2)#grab the center of the cell
        index += 1
      end
      return items
    end
    
  end

end