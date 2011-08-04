require 'test_helper'

class CollisionTreeTest < Test::Unit::TestCase

  def test_initialize
    parent_node = mock
    
    tree = CollisionTree.new parent_node
    
    assert tree.colliding_objects.size == 0
    assert tree.objects.size == 0
    assert_equal parent_node, tree.parent_node
  end

  def test_update_forces_detection_for_collidable_objects
    tree = CollisionTree.new mock
    collidable_object = stub(:hitbox => mock)  
    tree.objects << collidable_object
  
    collidable_object.hitbox.expects(:clear_colliding_objects)
    collidable_object.hitbox.expects(:collidable?).returns(true)
    tree.parent_node.expects(:update).with(tree.colliding_objects)
    tree.colliding_objects.expects(:clear)
    tree.colliding_objects.include? collidable_object
    
    tree.update
  end

end
