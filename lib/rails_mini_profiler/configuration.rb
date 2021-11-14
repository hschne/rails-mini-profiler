# frozen_string_literal: true

require 'rails_mini_profiler/configuration/storage'
require 'rails_mini_profiler/configuration/user_interface'

module RailsMiniProfiler
  # The main Rails Mini Profiler configuration object
  #
  # @!attribute [r] logger
  #   @return [Logger] the current logger
  # @!attribute enabled
  #   @return [Boolean] if the profiler is enabled
  # @!attribute flamegraph_enabled
  #   @return [Boolean] if Flamegraph recording is enabled
  # @!attribute flamegraph_sample_rate
  #   @return [Float] the sample rate in samples per millisecond
  # @!attribute skip_paths
  #   @return [Array<String>] a list of regex patterns for paths to skip
  # @!attribute storage
  #   @return [Storage] the storage configuration
  # @!attribute tracers
  #   @return [Array<Symbol>] the list of enabled tracers
  # @!attribute ui
  #   @return [UserInterface] the ui configuration
  # @!attribute user_provider
  #   @return [Proc] a proc to identify a user based on a rack env
  class Configuration
    attr_reader :logger

    attr_accessor :enabled,
                  :flamegraph_enabled,
                  :flamegraph_sample_rate,
                  :skip_paths,
                  :storage,
                  :tracers,
                  :ui,
                  :user_provider

    def initialize(**kwargs)
      reset
      kwargs.each { |key, value| instance_variable_set("@#{key}", value) }
    end

    # Reset the configuration to default values
    def reset
      @enabled = proc { |_env| Rails.env.development? || Rails.env.test? }
      @flamegraph_enabled = true
      @flamegraph_sample_rate = 0.5
      @logger = RailsMiniProfiler::Logger.new(Rails.logger)
      @skip_paths = []
      @storage = Storage.new
      @tracers = %i[controller instantiation sequel view rmp]
      @ui = UserInterface.new
      @user_provider = proc { |env| Rack::Request.new(env).ip }
    end

    # Set the logger
    #
    # @param logger [Logger]
    #   The logger to be used. If set to nil, the Rails default logger is used and the log level set to fatal
    def logger=(logger)
      if logger.nil?
        @logger.level = Logger::FATAL
      else
        @logger = logger
      end
    end
  end
end
