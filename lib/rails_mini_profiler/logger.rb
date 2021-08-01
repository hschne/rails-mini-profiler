# frozen_string_literal: true

module RailsMiniProfiler
  # Construct a new custom logger to log from within the engine
  module Logger
    # Extends a logger with additional formatting
    #
    # @return [Logger] a customized logger
    def self.new(logger)
      logger = logger.dup

      logger.formatter = logger.formatter ? logger.formatter.dup : ActiveSupport::Logger::SimpleFormatter.new

      logger.formatter.extend Formatter
      logger.extend(self)
    end

    # Custom formatter to add a RailsMiniProfiler tag to log messages
    module Formatter
      def call(severity, timestamp, progname, msg)
        super(severity, timestamp, progname, "[RailsMiniProfiler] #{msg}")
      end
    end
  end
end
