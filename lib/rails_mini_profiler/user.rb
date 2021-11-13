# frozen_string_literal: true

module RailsMiniProfiler
  class User
    class << self
      def current_user
        Thread.current[:rails_mini_profiler_current_user]
      end

      def get(env)
        new(Thread.current[:rails_mini_profiler_current_user], env).current_user
      end

      def authorize(user)
        Thread.current[:rails_mini_profiler_current_user] = user
      end

      def current_user=(user)
        Thread.current[:rails_mini_profiler_current_user] = user
      end
    end

    def initialize(current_user, env)
      @current_user = current_user
      @env = env
    end

    def current_user
      @current_user ||= find_current_user
    end

    def find_current_user
      return if Rails.env.production?

      user = RailsMiniProfiler.configuration.user_provider.call(@env)
      User.current_user = user
      user
    end
  end
end
