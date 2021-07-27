# frozen_string_literal: true

module RailsMiniProfiler
  class Redirect
    include Engine.routes.url_helpers

    def initialize(request_context)
      @request = request_context.request
      @profiled_request = request_context.profiled_request
    end

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
