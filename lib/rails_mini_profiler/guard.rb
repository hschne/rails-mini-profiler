# frozen_string_literal: true

module RailsMiniProfiler
  class Guard
    def initialize(request)
      @request = request
    end

    def profile?
      return false if ignored_path?

      true
    end

    private

    def ignored_path?
      # TODO: This changes based on mount point
      return true if /rails_mini_profiler/.match?(@request.path)

      ignored_paths = RailsMiniProfiler.configuration.ignored_paths

      return true if Regexp.union(ignored_paths).match?(@request.path)

      false
    end
  end
end
