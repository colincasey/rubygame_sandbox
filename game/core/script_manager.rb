
module Game::Core
    
  class ScriptManager
    
    @@actors = Hash.new
    
    def self.def_actor(properties)
      actors[properties.keys[0].to_s] = properties[properties.keys[0]]
    end
    
    def self.load_scripts_from(scripts_dir)
      Log.info "Loading script"
      Dir[File.join(".", scripts_dir, "*.actor")].each do |file|
        Log.info "   #{file}"
        instance_eval File.open(file).read
      end
    end
    
    def self.actors
      @@actors
    end
    
  end

end