# frozen_string_literal: true

module RailsMiniProfiler
  class ProfilerContext
    class << self
      def instance(configuration)
        @instance ||= new(configuration)
      end
    end

    attr_reader :configuration, :request_repository

    def initialize(configuration)
      @configuration = configuration
      @request_repository ||= RequestRepository.new(configuration.storage)
    end
  end
end
