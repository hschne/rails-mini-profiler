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
      return true if /#{Engine.routes.url_helpers.root_path}/.match?(@request.path)

      return true if asset_path?

      return true if actioncable_request?

      ignored_paths = @configuration.skip_paths
      return true if ignored_paths.any? && Regexp.union(ignored_paths).match?(@request.path)

      false
    end

    # Is the current request to the engine itself?
    #
    # @return [Boolean] if the request path matches the engine mount path
    def engine_path?
      # Try the Rails 8+ approach first
      engine_script_name = Engine.routes.find_script_name({})
      return true if engine_script_name.present? && /#{Regexp.escape(engine_script_name)}/.match?(@request.path)

      # Fallback: check if path starts with any known engine mount points
      # This is a common pattern where engines are mounted at /rails_mini_profiler
      return true if @request.path.start_with?('/rails_mini_profiler')

      false
    end

    # Is the current request an asset request, e.g. to webpacker packs or assets?
    #
    # @return [Boolean] if the request path matches packs or assets
    def asset_path?
      %r{^/assets}.match?(@request.path)
    end

    # Is the current request an actioncable ping
    #
    # @return [Boolean] if the request path matches the mount path of actioncable
    def actioncable_request?
      return false unless defined?(ActionCable)

      /#{ActionCable.server.config.mount_path}/.match?(@request.path)
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
