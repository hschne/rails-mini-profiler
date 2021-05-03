# frozen_string_literal: true

module RailsMiniProfiler
  module Authorization
    def self.authorize!
      Thread.current[:rails_mini_profiler_authorized] = true
    end

    def self.authorized?
      Thread.current[:rails_mini_profiler_authorized]
    end
  end
end
