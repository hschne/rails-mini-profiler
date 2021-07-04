# frozen_string_literal: true

module RailsMiniProfiler
  class ControllerTracePresenter < TracePresenter
    def label
      'Action Controller'
    end
  end
end
