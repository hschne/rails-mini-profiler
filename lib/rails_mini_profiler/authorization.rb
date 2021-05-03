# frozen_string_literal: true

module RailsMiniProfiler
  module Authorization
    def self.authorize!(env)
      Thread.current[:rails_mini_profiler_authorized] = @configuration.authorized.call(env)
    end

    def self.authorized?
      Thread.current[:rails_mini_profiler_authorized]
    end
  end
end
