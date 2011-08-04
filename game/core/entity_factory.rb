
module Game::Core

  class EntityFactory
    
    def create(name, px, py)
      Log.debug "Adding '#{@next_id}:#{name}' at #{px},#{py}"
      require "game/entities/#{name.downcase}.rb"
      return Game::Entites.const_get(name).new px, py
    end
    
  end

end