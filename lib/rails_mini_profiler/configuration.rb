# frozen_string_literal: true

module RailsMiniProfiler
  class Configuration
    attr_accessor :authorize,
                  :enabled,
                  :skip_paths,
                  :storage,
                  :user_provider

    def initialize
      super
      reset
    end

    def reset
      @enabled = true
      @storage = Storage::Memory
      @skip_paths = []
      @user_provider = proc { |env| Rack::Request.new(env).ip }
      @authorize = proc { |_env| !(Rails.env.development? || Rails.env.test?) }
    end
  end
end
