require 'test_helper'

class ScriptManagerTest < Test::Unit::TestCase
  
  def test_load_all_scripts_from_scripts_dir
    ScriptManager.load_scripts_from "/scripts"
    assert_not_nil ScriptManager.actors["fox"]
  end
  
end