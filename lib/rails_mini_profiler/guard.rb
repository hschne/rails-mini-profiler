# frozen_string_literal: true

module RailsMiniProfiler
  # Encapsulates guard conditions on whether or not to run certain parts of the profiler.
  class Guard
    # @param request_context [RequestContext] the current request context
    # @param configuration [Configuration] the current configuration
    def initialize(request_context, configuration: RailsMiniProfiler.configuration)
      @request_context = request_context
      @request = request_context.request
      @configuration = configuration
    end

    # Whether or not to profile
    #
    # Profiling is disabled the profiler has been flat out disabled in the configuration or if the current request path
    # matches on of the ignored paths.
    #
    # @return [Boolean] false if no profiling should be done
    def profile?
      return false unless enabled?

      return false if ignored_path?

      true
    end

    private

    # Is the path of the current request an ignored one?
    #
    # @return [Boolean] true if the path is ignored. Per default, paths going to the engine itself are ignored, as are
    #   asset requests, and the paths the user has configured.
    def ignored_path?
      return true if /#{Engine.routes.find_script_name({})}/.match?(@request.path)

      return true if /assets/.match?(@request.path)

      ignored_paths = @configuration.skip_paths
      return true if Regexp.union(ignored_paths).match?(@request.path)

      false
    end

    # Is the profiler enabled?
    #
    # Takes into account the current request env to decide if the profiler is enabled.
    #
    # @return [Boolean] false if the profiler is disabled
    def enabled?
      enabled = @configuration.enabled
      return enabled unless enabled.respond_to?(:call)

      enabled.call(@request.env)
    end
  end
end
