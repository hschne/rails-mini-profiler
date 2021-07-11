# frozen_string_literal: true

module RailsMiniProfiler
  class InstantiationTracePresenter < TracePresenter
    def label
      "#{model.class_name} Instantiation"
    end

    def description
      record_string = 'Record'.pluralize(model.record_count)
      "Instantiated #{model.record_count} #{model.class_name} #{record_string}"
    end
  end
end
