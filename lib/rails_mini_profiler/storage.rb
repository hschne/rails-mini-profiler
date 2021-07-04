# frozen_string_literal: true

module RailsMiniProfiler
  class Storage
    class << self
      def configuration
        @configuration ||= new.configuration
      end

      def configure
        yield(configuration)
      end
    end

    attr_accessor :profiled_request_table, :trace_table, :flamegraph_table

    def initialize(**kwargs)
      kwargs.each { |key, value| instance_variable_set("@#{key}", value) }
    end

    def defaults!
      super
      @profiled_request_table = 'profiled_requests'
      @flamegraph_table = 'flamegraphs'
      @trace_table = 'traces'
    end
  end
end
