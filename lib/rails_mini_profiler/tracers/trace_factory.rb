# frozen_string_literal: true

module RailsMiniProfiler
  module Tracers
    # Creates traces based on the tracers registered with the application
    #
    # For example, an event with name 'sequel' will result in the lookup of a tracers that responds to that particular
    # event. The tracer itself will then build the trace from the event.
    #
    # @api private
    class TraceFactory
      def initialize(registry)
        @tracers = registry.tracers
      end

      # Create a new trace from an event
      #
      # @param event [ActiveSupport::Notifications::Event] an event from the application
      #
      # @return [Trace] a processed trace
      def create(event)
        tracer = @tracers[event.name] || Tracer
        tracer.build_from(event)
      end
    end
  end
end
