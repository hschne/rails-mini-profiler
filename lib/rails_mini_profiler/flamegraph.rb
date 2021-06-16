# frozen_string_literal: true

module RailsMiniProfiler
  class Flamegraph
    def initialize(profiled_request)
      @profiled_request = profiled_request
    end

    def enabled?
      defined?(StackProf) && StackProf.respond_to?(:run)
    end

    def record(&block)
      return block.call unless enabled?

      result = nil
      flamegraph = StackProf.run(mode: :wall, raw: true, aggregate: false, interval: (2 * 1000).to_i) do
        result = block.call
      end
      @profiled_request.flamegraph = flamegraph
      result
    end
  end
end
