# frozen_string_literal: true

module RailsMiniProfiler
  module Tracers
    class Tracer
      TIMESTAMP_MULTIPLIER = 100_000

      class << self
        def subscribes_to
          []
        end

        def presents
          TracePresenter
        end

        def build_from(event)
          new(event).trace
        end
      end

      def initialize(event)
        @event = event_data(event)
      end

      def trace
        Trace.new(**@event)
      end

      private

      def event_data(event)
        # Rails 7 changes event timings and now uses CPU milliseconds as float for start and end. We multiply by 100
        # to convert the float with precision of 2 digits to integer, because integers are just easier to store and
        # process than floats.
        #
        # See https://github.com/rails/rails/commit/81d0dc90becfe0b8e7f7f26beb66c25d84b8ec7f
        start_time = (event.time.to_f * 100).to_i
        finish_time = (event.end.to_f * 100).to_i
        {
          name: event.name,
          start: start_time,
          finish: finish_time,
          duration: (event.duration.to_f * 100).to_i,
          allocations: event.allocations,
          backtrace: Rails.backtrace_cleaner.clean(caller),
          payload: event.payload
        }
      end
    end
  end
end
