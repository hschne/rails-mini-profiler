# frozen_string_literal: true

module RailsMiniProfiler
  class Guard
    def initialize(request_context, configuration: RailsMiniProfiler.configuration)
      @request_context = request_context
      @request = request_context.request
      @configuration = configuration
    end

    def profile?
      return false unless enabled?

      return false if ignored_path?

      true
    end

    def store?
      return false unless @request_context.user

      true
    end

    private

    def ignored_path?
      return true if /#{Engine.routes.find_script_name({})}/.match?(@request.path)

      return true if /assets/.match?(@request.path)

      ignored_paths = @configuration.skip_paths

      return true if Regexp.union(ignored_paths).match?(@request.path)

      false
    end

    def enabled?
      enabled = @configuration.enabled
      return enabled unless enabled.respond_to?(:call)

      enabled.call(@request.env)
    end
  end
end
