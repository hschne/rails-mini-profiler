# frozen_string_literal: true

module RailsMiniProfiler
  module Tracing
    class ControllerTracer < Tracer
      def trace
        @event[:payload] = @event[:payload]
                             .slice(:view_runtime, :db_runtime)
                             .reject { |_k, v| v.blank? }
                             .transform_values { |value| value&.round(2) }
        super
      end
    end
  end
end
