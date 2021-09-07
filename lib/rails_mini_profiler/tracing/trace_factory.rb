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
        trace = trace_class.new(**options)
        return NullTrace.new if trace.ignore?

        trace.transform!
        trace
      end

      private

      def trace_class
        case @event.name
        when 'sql.active_record'
          SequelTrace
        when 'render_template.action_view', 'render_partial.action_view'
          ViewTrace
        when 'process_action.action_controller'
          ControllerTrace
        else
          Trace
        end
      end

      def options
        start = (@event.time.to_f * 100_000).to_i
        finish = (@event.end.to_f * 100_000).to_i
        {
          name: @event.name,
          start: start,
          finish: finish,
          duration: finish - start,
          allocations: @event.allocations,
          backtrace: Rails.backtrace_cleaner.clean(caller),
          payload: @event.payload
        }
      end
    end
  end
end
