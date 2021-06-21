# frozen_string_literal: true

module RailsMiniProfiler
  class ProfiledRequest < ApplicationRecord
    self.table_name = 'rmp_profiled_requests'

    has_many :rmp_traces, class_name: 'RailsMiniProfiler::Trace'
  end
end
