module Game::Core  
  class Log        
    class << self                    
      def debug(message)
        logger.debug message
      end
      
      def info(message)
        logger.info message
      end
      
      def error(message)
        logger.error message
      end
      
      def warn(message)
        logger.warn message
      end
      
      private
      def logger        
        @logger ||= create_logger
      end
      
      def create_logger
        logger = Log4r::Logger.new 'rubygame sandbox'
        logger.add console_output
        logger.add file_output
        logger.level = Log4r::DEBUG   
        logger     
      end
      
      def console_output
        console_format = Log4r::PatternFormatter.new(:pattern => "%l:\t %m")
        Log4r::StdoutOutputter.new('console', :formatter => console_format)
      end
      
      def file_output
        file_format = Log4r::PatternFormatter.new(:pattern => "[ %d ] %l\t %m")
        log_file = File.dirname(__FILE__) + '/../game.log'
        Log4r::FileOutputter.new('fileOutputter', :filename => log_file, :trunc => false, :formatter=>file_format)
      end  
    end  
  end
end 

 
