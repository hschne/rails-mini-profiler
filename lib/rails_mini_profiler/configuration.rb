# frozen_string_literal: true

module RailsMiniProfiler
  class Configuration
    attr_accessor :authorize,
                  :enabled,
                  :flamegraph_enabled,
                  :skip_paths,
                  :storage,
                  :user_provider

    def initialize
      super
      reset
    end

    def reset
      @authorize = proc { |_env| !(Rails.env.development? || Rails.env.test?) }
      @enabled = proc { |_env| !(Rails.env.development? || Rails.env.test?) }
      @flamegraph_enabled = true
      @skip_paths = []
      @storage = Storage::Memory
      @user_provider = proc { |env| Rack::Request.new(env).ip }
    end
  end
end
