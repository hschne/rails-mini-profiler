# frozen_string_literal: true

module RailsMiniProfiler
  # Configure various aspects about Rails Mini Profilers UI.
  #
  # @!attribute page_size
  #   @return [Integer] how many items to render per page in list views
  class UserInterface
    class << self
      # Construct a new UI configuration instance
      #
      # @return [UserInterface] a new storage configuration
      def configuration
        @configuration ||= new
      end

      # Configure how profiling data is shown to the user
      #
      # @yieldreturn [UserInterface] a new UI configuration object
      def configure
        yield(configuration)
        configuration
      end
    end

    attr_accessor :page_size

    def initialize(**kwargs)
      defaults!
      kwargs.each { |key, value| instance_variable_set("@#{key}", value) }
    end

    # Reset the configuration to default values
    def defaults!
      @page_size = 25
    end
  end
end
