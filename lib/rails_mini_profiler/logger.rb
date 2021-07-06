# frozen_string_literal: true

module RailsMiniProfiler
  module Logger
    def self.new(logger)
      logger = logger.dup

      logger.formatter = if logger.formatter
                           logger.formatter.dup
                         else
                           # Ensure we set a default formatter so we aren't extending nil!
                           ActiveSupport::Logger::SimpleFormatter.new
                         end

      logger.formatter.extend Formatter
      logger.extend(self)
    end

    module Formatter
      def call(severity, timestamp, progname, msg)
        super(severity, timestamp, progname, "[RailsMiniProfiler] #{msg}")
      end
    end
  end
end
