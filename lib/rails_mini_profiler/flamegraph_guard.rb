# frozen_string_literal: true

module RailsMiniProfiler
  class FlamegraphGuard
    def initialize(request_context, configuration: RailsMiniProfiler.configuration)
      @request_context = request_context
      @request = request_context.request
      @configuration = configuration
    end

    def record(&block)
      return block.call unless enabled?

      sample_rate = @configuration.flamegraph_sample_rate
      if StackProf.running?
        RailsMiniProfiler.logger.debug('Stackprof is already running, cannot record Flamegraph')
        return block.call
      end

      result = nil
      flamegraph = StackProf.run(mode: :wall, raw: true, aggregate: false, interval: (sample_rate * 1000).to_i) do
        result = block.call
      end

      unless flamegraph
        RailsMiniProfiler.logger.debug('Failed to record Flamegraph, possibly due to concurrent requests')
        return result
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

      RailsMiniProfiler.configuration.flamegraph_enabled
    end
  end
end
