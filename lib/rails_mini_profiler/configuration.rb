# frozen_string_literal: true

module RailsMiniProfiler
  class Configuration
    attr_accessor :authorize,
                  :enabled,
                  :flamegraph_enabled,
                  :skip_paths,
                  :storage,
                  :storage_options,
                  :storage_limit,
                  :user_provider

    def initialize(**kwargs)
      reset
      kwargs.each { |key, value| instance_variable_set("@#{key}", value) }
    end

    def reset
      @authorize = proc { |_env| !(Rails.env.development? || Rails.env.test?) }
      @enabled = proc { |_env| !(Rails.env.development? || Rails.env.test?) }
      @flamegraph_enabled = true
      @skip_paths = []
      @storage = Storage::Memory
      @storage_options = nil
      @storage_limit = 50
      @user_provider = proc { |env| Rack::Request.new(env).ip }
    end
  end
end
