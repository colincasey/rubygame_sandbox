require 'test_helper'

class CollisionHitBoxTest < Test::Unit::TestCase  
  def test_initialize
    rect = mock
    hitbox = CollisionHitbox.new rect
    
    assert hitbox.colliding_with.size == 0
    assert hitbox.collidable == false
    assert_equal rect, hitbox.rect
  end
  
  def test_can_clear_colliding_objects
    hitbox = CollisionHitbox.new mock
    hitbox.colliding_with << :object
    
    hitbox.clear_colliding_objects
    
    assert hitbox.colliding_with.size == 0
  end
  
  def test_can_add_colliding_object
    hitbox = CollisionHitbox.new mock
    
    hitbox.collide_with :abc
    
    assert hitbox.colliding_with.include? :abc
  end
  
  def test_can_only_add_colliding_object_once
    hitbox = CollisionHitbox.new mock
    
    hitbox.collide_with :abc
    hitbox.collide_with :abc
    
    assert hitbox.colliding_with.size == 1
  end
  
  def test_can_check_if_hitbox_is_colliding
    hitbox = CollisionHitbox.new mock
    
    assert hitbox.colliding? == false
    
    hitbox.collide_with :abc
    
    assert hitbox.colliding? == true
  end
  
  def test_can_detect_collision_between_two_hitboxes
    hitbox_a = CollisionHitbox.new mock
    hitbox_b = CollisionHitbox.new mock
    
    hitbox_a.rect.expects(:collide_rect?).with(hitbox_b.rect).returns(true)

    assert hitbox_a.collision_detected?(hitbox_b) == true
  end

  def test_can_enable_collision
    hitbox = CollisionHitbox.new mock
    
    hitbox.enable_collision
    
    assert hitbox.collidable == true
  end
  
  def test_can_disable_collision
    hitbox = CollisionHitbox.new mock
    
    hitbox.disable_collision
    
    assert hitbox.collidable == false
  end
  
end
