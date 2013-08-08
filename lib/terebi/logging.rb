require 'awesome_print'
require 'logger'

module Terebi
  module Logging

    def self.initialize_logger(log_target = STDOUT)
      @logger = Logger.new(log_target)
      @logger.level = Logger::INFO

      @logger.formatter = proc do |severity, datetime, progname, msg|
         "[#{datetime.strftime("%I:%M.%S%p").downcase}] #{severity.rjust(5)} : #{msg}\n"
      end

      @logger
    end

    def self.logger
      @logger || initialize_logger
    end

    def self.logger=(log)
      @logger = (log ? log : Logger.new('/dev/null'))
    end

    def logger
      Terebi::Logging.logger
    end

  end
end
