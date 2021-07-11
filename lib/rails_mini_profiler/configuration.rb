# frozen_string_literal: true

module RailsMiniProfiler
  class Configuration
    attr_reader :logger

    attr_accessor :enabled,
                  :badge_enabled,
                  :badge_position,
                  :flamegraph_enabled,
                  :skip_paths,
                  :storage,
                  :user_provider

    def initialize(**kwargs)
      reset
      kwargs.each { |key, value| instance_variable_set("@#{key}", value) }
    end

    def reset
      @enabled = proc { |_env| Rails.env.development? || Rails.env.test? }
      @badge_enabled = true
      @badge_position = 'top-left'
      @flamegraph_enabled = true
      @logger = RailsMiniProfiler::Logger.new(Rails.logger)
      @skip_paths = []
      @storage = Storage.new
      @user_provider = proc { |env| Rack::Request.new(env).ip }
    end

    def logger=(logger)
      if logger.nil?
        @logger.level = Logger::FATAL
      else
        @logger = logger
      end
    end
  end
end
