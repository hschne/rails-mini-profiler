module RailsMiniProfiler
  class TraceRecord < ApplicationRecord
    belongs_to :request_id
  end
end
