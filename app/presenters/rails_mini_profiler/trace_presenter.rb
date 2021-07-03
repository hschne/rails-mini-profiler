# frozen_string_literal: true

module RailsMiniProfiler
  class TracePresenter < BasePresenter
    def initialize(trace, view, profiled_request:)
      super(trace, view)
      @profiled_request = profiled_request
    end

    def description
      'Random Description'
    end

    def type
      self.class.trace_type(name)
    end

    def duration
      model.duration.to_f / 100
    end

    def percent
      (model.duration.to_f / @profiled_request.duration * 100).round
    end

    def from_start
      (model.start - @profiled_request.start).to_f / 100
    end

    def from_start_percent
      ((model.start - @profiled_request.start).to_f /
        (@profiled_request.finish - @profiled_request.start)).to_f * 100
    end
  end
end
