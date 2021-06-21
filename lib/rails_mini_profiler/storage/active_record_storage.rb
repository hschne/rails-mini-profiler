# frozen_string_literal: true

module Storage
  class ActiveRecordStorage
    class << self
      def configure
        yield(configuration)
      end

      private

      def configuration
        @configuration ||= ActiveRecordStorage.new
      end
    end

    attr_accessor :profiled_request_table, :trace_table, :flamegraph_table

    def initialize(**kwargs)
      defaults!
      kwargs.each { |key, value| instance_variable_set("@#{key}", value) }
    end

    def defaults!
      @profiled_request_table = 'profiled_requests'
      @flamegraph_table = 'flamegraphs'
      @trace_table = 'traces'
    end
  end
end
