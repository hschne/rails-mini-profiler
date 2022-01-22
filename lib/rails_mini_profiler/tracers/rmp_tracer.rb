# frozen_string_literal: true

module RailsMiniProfiler
  module Tracers
    class RmpTracer < Tracer
      class << self
        def subscribes_to
          'rails_mini_profiler.total_time'
        end

        def presents
          RmpTracePresenter
        end
      end
    end
  end
end
