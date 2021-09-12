# frozen_string_literal: true

module RailsMiniProfiler
  module Tracing
    class ControllerTracer < Tracer
      def trace
        payload = @event[:payload]
                    .slice(:view_runtime, :db_runtime)
                    .transform_values { |value| value&.round(2) }
        payload.reject { |_k, v| v.blank? }
        @event[:payload] = payload
        super
      end
    end
  end
end
