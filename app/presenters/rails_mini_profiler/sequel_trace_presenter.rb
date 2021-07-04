# frozen_string_literal: true

module RailsMiniProfiler
  class SequelTracePresenter < TracePresenter
    def description
      model.payload['sql']
    end
  end
end
