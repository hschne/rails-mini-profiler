# frozen_string_literal: true

module RailsMiniProfiler
  module Repositories
    module ActiveRecord
      class TraceRepository < Repositories::TraceRepository
        def initialize(request_id)
          super
          @record = RailsMiniProfiler::Trace
        end

        def insert_all(records)
          timestamp = ::ActiveRecord::Base.default_timezone == :utc ? Time.now.utc : Time.now
          inserts = records.map do |record|
            { rmp_profiled_request_id: @request_id, **record.to_h, created_at: timestamp, updated_at: timestamp }
          end
          @record.insert_all(inserts)
        end
      end
    end
  end
end
