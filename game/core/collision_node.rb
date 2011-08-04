
module Game::Core
  
  class CollisionNode
  
    attr_reader :rect
    attr_reader :child_nodes;
    attr_reader :objects_in_this_node;
    attr_reader :contains_objects;
    attr_reader :depth;
    
    def initialize(rectangle, depth)
      @rect = rectangle
      @child_nodes = []
      @objects_in_this_node = []
      @depth = depth
      create_child_nodes if not top_node?
    end
    
    def top_node?
      depth == 0
    end
    
    def contains_objects?
      @objects_in_this_node.size > 0
    end
    
    def x
      @rect.x
    end
    
    def y
      @rect.y
    end
    
    def width
      @rect.width
    end
    
    def height
      @rect.height
    end
    
    def top
      @rect.y
    end
    
    def bottom
      @rect.y + @rect.height
    end
    
    def left
      @rect.x
    end
    
    def right
      @rect.x + @rect.width
    end
    
    def create_child_nodes
      child_depth = @depth - 1
      
      arect = Rubygame::Rect.new self.x, self.y, self.width / 2, self.height / 2
      a = CollisionNode.new arect, child_depth
      @child_nodes << a       
             
       brect = Rubygame::Rect.new a.right, self.y, self.right - a.right, a.height
       b = CollisionNode.new brect, child_depth
       @child_nodes << b
                
       drect = Rubygame::Rect.new self.x, a.bottom, a.width, (self.bottom - self.top) / 2
       d = CollisionNode.new drect, child_depth
       @child_nodes << d
                
       crect = Rubygame::Rect.new b.x, d.y, b.width, d.height
       c = CollisionNode.new crect, child_depth         
       @child_nodes << c
    end
  
    def update(objects)
      get_objects_inside_this_node objects
      return if not contains_objects?
        
      if not top_node? && objects.size > 1
        child_nodes.each { |node| node.update @objects }
      else
        check_for_collisions_in_this_node  
      end
      
    end
    
    private
    
    def get_objects_inside_this_node(objects)
      @objects_in_this_node.clear
      return if objects.nil?
      objects.each do |obj|
        if @rect.collide_rect? obj.hitbox.rect
          @objects_in_this_node << obj
        end
      end
    end
    
    def check_for_collisions_in_this_node
      @objects_in_this_node.each do |obj1|
        @objects_in_this_node.each do |obj2|
          next if obj1 == obj2 #ignore self
          detect_collision obj1, obj2 
        end
      end
      @objects_in_this_node.delete_at 0         
    end
    
    def detect_collision(obj1, obj2)
      if obj1.hitbox.collision_detected? obj2.hitbox
          obj1.hitbox.collide_with obj2
          obj2.hitbox.collide_with obj1
      end
    end
  
  end
  
end