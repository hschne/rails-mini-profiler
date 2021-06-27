# frozen_string_literal: true

module RailsMiniProfiler
  class Trace < ApplicationRecord
    self.table_name = 'rmp_traces'

    belongs_to :profiled_request, class_name: 'RailsMiniProfiler::ProfiledRequest', foreign_key: :rmp_profiled_request_id
  end
end
