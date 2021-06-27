# frozen_string_literal: true

module RailsMiniProfiler
  class FlamegraphGuard
    def initialize(request)
      @request = request
    end

    def record(profiled_request, &block)
      return block.call unless enabled?

      result = nil
      flamegraph = StackProf.run(mode: :wall, raw: true, aggregate: false, interval: (2 * 1000).to_i) do
        result = block.call
      end
      profiled_request.flamegraph = flamegraph
      result
    end

    private

    def enabled?
      defined?(StackProf) && StackProf.respond_to?(:run) && config_enabled?
    end

    def config_enabled?
      params = CGI.parse(@request.query_string).transform_values(&:first).with_indifferent_access
      return params[:rmp_flamegraph] if params[:rmp_flamegraph]

      RailsMiniProfiler.configuration.flamegraph_enabled
    end
  end
end
