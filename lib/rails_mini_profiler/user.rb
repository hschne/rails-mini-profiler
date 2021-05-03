# frozen_string_literal: true

module RailsMiniProfiler
  module User
    def self.current_user=(user)
      Thread.current[:rails_mini_profiler_current_user] = user
    end

    def self.authorized?
      Thread.current[:rails_mini_profiler_current_user]
    end
  end
end
