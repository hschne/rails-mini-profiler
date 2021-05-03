# frozen_string_literal: true

module RailsMiniProfiler
  class Guard
    def initialize(request_context)
      @request_context = request_context
      @request = request_context.request
      @configuration = request_context.profiler_context.configuration
    end

    def profile?
      return false unless @configuration.enabled

      return false if ignored_path?

      true
    end

    def store?
      return false unless @request_context.user

      true
    end

    private

    def ignored_path?
      # TODO: This changes based on mount point
      return true if /rails_mini_profiler/.match?(@request.path)

      return true if /assets/.match?(@request.path)

      ignored_paths = @configuration.skip_paths

      return true if Regexp.union(ignored_paths).match?(@request.path)

      false
    end
  end
end
