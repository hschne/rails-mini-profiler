# frozen_string_literal: true

module RailsMiniProfiler
  # Renders a redirect response if the user should be redirected from the original request
  class Redirect
    include Engine.routes.url_helpers

    # @param request_context [RequestContext] the current request context
    def initialize(request_context)
      @request = request_context.request
      @profiled_request = request_context.profiled_request
    end

    # Renders a redirect to a specific resource under certain conditions
    #
    # When the user requests a Flamegraph using a parameter for a specific request, they are being served a redirect.
    #
    # @return [Boolean] false if no redirect happens
    # @return [Array] response with status 302 and the new location to redirect to
    def render
      params = CGI.parse(@request.query_string).transform_values(&:first).with_indifferent_access
      return redirect_to(flamegraph_path(@profiled_request.id)) if params[:rmp_flamegraph]

      false
    end

    private

    def redirect_to(location)
      [302, { 'Location' => location, 'Content-Type' => 'text/html' }, ['Moved Temporarily']]
    end
  end
end
