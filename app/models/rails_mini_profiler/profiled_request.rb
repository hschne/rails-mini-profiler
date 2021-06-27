# frozen_string_literal: true

module RailsMiniProfiler
  class ProfiledRequest < ApplicationRecord
    self.table_name = 'rmp_profiled_requests'

    has_many :traces, class_name: 'RailsMiniProfiler::Trace', foreign_key: :rmp_profiled_request_id

  end
end
