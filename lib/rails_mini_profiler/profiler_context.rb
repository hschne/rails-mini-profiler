# frozen_string_literal: true

module RailsMiniProfiler
  class ProfilerContext
    class << self
      def instance(configuration)
        @instance ||= new(configuration)
      end
    end

    attr_reader :configuration, :storage_instance

    def initialize(configuration)
      @configuration = configuration
      @storage_instance ||= configuration.storage.new
    end
  end
end
