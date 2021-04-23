# frozen_string_literal: true

module RailsMiniProfiler
  class ExecutionContext
    class << self
      def instance(configuration)
        @instance ||= new(configuration)
      end
    end

    attr_reader :storage_instance

    def initialize(configuration)
      @configuration = configuration
      @storage_instance ||= configuration.storage.new
    end
  end
end
