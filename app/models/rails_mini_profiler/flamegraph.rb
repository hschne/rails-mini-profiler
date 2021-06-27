# frozen_string_literal: true

module RailsMiniProfiler
  class Flamegraph < ApplicationRecord
    self.table_name = 'rmp_flamegraphs'

    belongs_to :profiled_request, class_name: 'RailsMiniProfiler::ProfiledRequest',
                                  foreign_key: :rmp_profiled_request_id
  end
end
