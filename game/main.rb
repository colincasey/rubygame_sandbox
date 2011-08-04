# load dependent required gems
require "rubygems"
require "bundler/setup"
Bundler.require

# set the load path to the directory above the one this script is in
$:.unshift File.expand_path('..', File.dirname(__FILE__))

# todo: fix requires so this isn't necessary
module Game
  module Core; end  
end

#require "game/bootstrap"
require "game/core/scene_manager_factory"

include Game::Core

module Game

  class Main
   
    def initialize
      require "game/core/log"
      Game::Core::Log.configure
      @scene_manager = SceneManagerFactory.create
    end
  
    def run
        catch(:quit) do
          loop do
            @scene_manager.tick
          end
        end
        Rubygame.quit()
    end
      
  end

end