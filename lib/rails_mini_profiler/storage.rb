# frozen_string_literal: true

module RailsMiniProfiler
  # Configure how profiling data is stored within your Rails app.
  #
  # @!attribute database
  #   @return [Symbol] which database to connect to
  # @!attribute profiled_requests_table
  #   @return [Symbol] where to store profiled requests
  # @!attribute traces_table
  #   @return [Symbol] where to store traces
  # @!attribute flamegraphs_table
  #   @return [Symbol] where to store flamegraphs
  class Storage
    class << self
      # Construct a new configuration instance
      #
      # @return [Storage] a new storage configuration
      def configuration
        @configuration ||= new
      end

      # Configure how profiling data is stored
      #
      # @yieldreturn [Storage] a new storage configuration object
      def configure
        yield(configuration)
      end
    end

    attr_accessor :database, :profiled_requests_table, :traces_table, :flamegraphs_table

    def initialize(**kwargs)
      defaults!
      kwargs.each { |key, value| instance_variable_set("@#{key}", value) }
    end

    # Reset the configuration to default values
    def defaults!
      @database = nil
      @profiled_requests_table = 'rmp_profiled_requests'
      @flamegraphs_table = 'rmp_flamegraphs'
      @traces_table = 'rmp_traces'
    end
  end
end
