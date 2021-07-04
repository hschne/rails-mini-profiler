# frozen_string_literal: true

module RailsMiniProfiler
  RailsMiniProfilerError = Class.new(StandardError)

  # Storage errors
  StorageError = Class.new(RailsMiniProfilerError)
end
