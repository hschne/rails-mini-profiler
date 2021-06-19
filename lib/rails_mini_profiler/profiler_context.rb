# frozen_string_literal: true

module RailsMiniProfiler
  class ProfilerContext
    class << self
      def instance(configuration)
        @instance ||= new(configuration)
      end
    end

    attr_reader :configuration

    def initialize(configuration)
      @configuration = configuration
    end
  end
end
