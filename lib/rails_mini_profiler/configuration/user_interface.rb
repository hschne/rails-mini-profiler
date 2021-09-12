# frozen_string_literal: true

module RailsMiniProfiler
  # Configure various aspects about Rails Mini Profilers UI.
  #
  # @!attribute badge_enabled
  #   @see Badge
  #   @return [Boolean] if the badge should be enabled
  # @!attribute badge_position
  #   @see Badge
  #   @return [String] the position of the interactive HTML badge
  # @!attribute page_size
  #   @return [Integer] how many items to render per page in list views
  # @!attribute webpacker_enabled
  #   @return [Boolean] if webpacker assets should be used. Disable to fall back to the asset pipeline
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

    attr_accessor :badge_enabled,
                  :badge_position,
                  :page_size,
                  :webpacker_enabled

    def initialize(**kwargs)
      defaults!
      kwargs.each { |key, value| instance_variable_set("@#{key}", value) }
    end

    # Reset the configuration to default values
    def defaults!
      @badge_enabled = true
      @badge_position = 'top-left'
      @page_size = 25
      @webpacker_enabled = true
    end
  end
end
