
module Game::Core

  class CollisionTree #AKA QuadTree
    
    attr_reader :colliding_objects
    attr_reader :objects
    attr_reader :parent_node
    
    def initialize(parent_node)
      @colliding_objects = []
      @objects = []
      @parent_node = parent_node
    end
    
    def update
      @colliding_objects.clear
      @objects.each do |obj|
        obj.hitbox.clear_colliding_objects();
        if obj.hitbox.collidable? then @colliding_objects << obj end
      end
      @parent_node.update @colliding_objects
    end
    
  end

end