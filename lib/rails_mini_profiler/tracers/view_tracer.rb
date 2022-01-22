# frozen_string_literal: true

module RailsMiniProfiler
  module Tracers
    class ViewTracer < Tracer
      class << self
        def subscribes_to
          %w[render_template.action_view render_partial.action_view]
        end

        def build_from(event)
          new(event).trace
        end

        def presents
          {
            'render_template.action_view' => RenderTemplateTracePresenter,
            'render_partial.action_view' => RenderPartialTracePresenter
          }
        end
      end

      def trace
        @event[:payload].slice!(:identifier, :count)
        super
      end
    end
  end
end
