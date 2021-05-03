# frozen_string_literal: true

module RailsMiniProfiler
  module User
    def self.current_user
      Thread.current[:rails_mini_profiler_current_user]
    end

    def self.current_user=(user)
      Thread.current[:rails_mini_profiler_current_user] = user
    end
  end
end
