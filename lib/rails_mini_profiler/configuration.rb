# frozen_string_literal: true

module RailsMiniProfiler
  class Configuration
    attr_accessor :enabled,
                  :badge_enabled,
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
      @flamegraph_enabled = true
      @skip_paths = []
      @storage = Storage::Memory
      @user_provider = proc { |env| Rack::Request.new(env).ip }
    end
  end
end
