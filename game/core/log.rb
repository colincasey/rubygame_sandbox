include Log4r

module Game::Core
  
  class Log
  
    @@log = Logger.new 'rubygame sandbox'
    
    def self.configure
      self.add_console_out
      self.add_file_out
      @@log.level = DEBUG
    end
  
    def self.debug(message)
      @@log.debug message
    end
    
    def self.info(message)
      @@log.info message
    end
    
    def self.error(message)
      @@log.error message
    end
    
    def self.warn(message)
      @@log.warn message
    end
    
    private
    
    def self.add_console_out
      console_format = PatternFormatter.new(:pattern => "%l:\t %m")
      @@log.add Log4r::StdoutOutputter.new('console', :formatter=>console_format)
    end
    
    def self.add_file_out
      file_format = PatternFormatter.new(:pattern => "[ %d ] %l\t %m")
      log_file = File.dirname(__FILE__) + '/../game.log'
      @@log.add FileOutputter.new('fileOutputter', :filename => log_file, :trunc => false, :formatter=>file_format)
    end
    
  end

end 

 
