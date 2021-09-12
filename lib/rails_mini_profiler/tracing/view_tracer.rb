# frozen_string_literal: true

module RailsMiniProfiler
  module Tracing
    class ViewTracer < Tracer
      def trace
        @event[:payload].slice!(:identifier, :count)
        super
      end
    end
  end
end
