# frozen_string_literal: true

module RailsMiniProfiler
  class InstantiationTracePresenter < TracePresenter
    def label
      "#{class_name} Instantiation"
    end

    def class_name
      payload['class_name']
    end

    def record_count
      payload['record_count']
    end

    def db_runtime
      payload['db_runtime']
    end

    def description
      record_string = 'Record'.pluralize(record_count)
      "Instantiated #{record_count} #{class_name} #{record_string}"
    end
  end
end
