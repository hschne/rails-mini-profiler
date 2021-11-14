# frozen_string_literal: true

module RailsMiniProfiler
  module Tracers
    class ControllerTracer < Tracer
      class << self
        def subscribes_to
          'process_action.action_controller'
        end

        def build_from(event)
          new(event).trace
        end

        def presents
          ControllerTracePresenter
        end
      end

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
