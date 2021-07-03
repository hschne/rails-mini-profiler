# frozen_string_literal: true

module RailsMiniProfiler
  class QueryTracePresenter < TracePresenter
    def description
      model.payload['sql']
    end
  end
end
