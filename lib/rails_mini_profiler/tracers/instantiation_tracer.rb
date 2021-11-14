# frozen_string_literal: true

module RailsMiniProfiler
  module Tracers
    class InstantiationTracer < Tracer
      class << self
        def subscribes_to
          'instantiation.active_record'
        end

        def presents
          InstantiationTracePresenter
        end
      end
    end
  end
end
