# frozen_string_literal: true

module RailsMiniProfiler
  class FlamegraphGuard
    def initialize(request_context)
      @request_context = request_context
      @request = request_context.request
    end

    def record(&block)
      return block.call unless enabled?

      result = nil
      flamegraph = StackProf.run(mode: :wall, raw: true, aggregate: false, interval: (2 * 1000).to_i) do
        result = block.call
      end
      @request_context.flamegraph = flamegraph.to_json
      result
    end

    private

    def enabled?
      defined?(StackProf) && StackProf.respond_to?(:run) && config_enabled?
    end

    def config_enabled?
      params = CGI.parse(@request.query_string).transform_values(&:first).with_indifferent_access
      return params[:rmp_flamegraph] if params[:rmp_flamegraph]

      # TODO: Configuration takes precedence
      RailsMiniProfiler.configuration.flamegraph_enabled
    end
  end
end
