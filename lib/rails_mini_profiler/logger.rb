# frozen_string_literal: true

module RailsMiniProfiler
  module Logger
    def self.new(logger)
      logger = logger.dup

      logger.formatter = logger.formatter ? logger.formatter.dup : ActiveSupport::Logger::SimpleFormatter.new

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
