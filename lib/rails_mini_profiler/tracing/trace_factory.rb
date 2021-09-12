# frozen_string_literal: true

module RailsMiniProfiler
  module Tracing
    class TraceFactory
      class << self
        def create(event)
          factory = new(event)
          factory.create
        end
      end

      def initialize(event)
        @event = event
      end

      def create
        trace_class.new(@event).trace
      end

      private

      def trace_class
        case @event.name
        when 'sql.active_record'
          SequelTracer
        when 'render_template.action_view', 'render_partial.action_view'
          ViewTracer
        when 'process_action.action_controller'
          ControllerTracer
        else
          Tracer
        end
      end
    end
  end
end
