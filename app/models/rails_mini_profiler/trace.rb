# frozen_string_literal: true

module RailsMiniProfiler
  class Trace < ApplicationRecord
    self.table_name = 'rmp_traces'

    belongs_to :rails_mini_profiler_profiled_request_record, class_name: 'RailsMiniProfiler::ProfiledRequest'
  end
end
