# frozen_string_literal: true

module RailsMiniProfiler
  class Storage
    class << self
      def configuration
        @configuration ||= new
      end

      def configure
        yield(configuration)
      end
    end

    attr_accessor :database, :profiled_requests_table, :traces_table, :flamegraphs_table

    def initialize(**kwargs)
      defaults!
      kwargs.each { |key, value| instance_variable_set("@#{key}", value) }
    end

    def defaults!
      @database = nil
      @profiled_requests_table = 'rmp_profiled_requests'
      @flamegraphs_table = 'rmp_flamegraphs'
      @traces_table = 'rmp_traces'
    end
  end
end
