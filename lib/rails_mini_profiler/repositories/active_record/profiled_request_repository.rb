# frozen_string_literal: true

module RailsMiniProfiler
  module Repositories
    module ActiveRecord
      class ProfiledRequestRepository < Repositories::ProfiledRequestRepository
        def all
          RailsMiniProfiler::ProfiledRequest.where(user_id: @user_id)
        end

        def find(id)
          all.find(id)
        rescue ::ActiveRecord::RecordNotFound
          raise(RecordNotFound, "Record with id='#{id}' not found")
        end

        def find_by(**kwargs)
          all.where(**kwargs)
        end

        def create(request)
          ::ActiveRecord::Base.transaction do
            save_request(request)
          end
        end

        def update(request)
          find(request.id).update(request.to_h)
        end

        def destroy(request_id)
          find(request_id).destroy
        end

        def clear
          all.destroy_all
        end

        private

        def save_request(request)
          attributes = request.to_h
                         .except('traces', 'flamegraph')
                         .merge(user_id: @user_id)
          profiled_request = ProfiledRequest.create(attributes)
          if profiled_request.flamegraph
            Flamegraph.create(profiled_request: profiled_request, data: request.flamegraph.data)
          end
          insert_traces(profiled_request.id, request.traces) unless request.traces.empty?
          profiled_request
        end

        def insert_traces(request_id, records)
          timestamp = Time.zone.now
          inserts = records.map do |record|
            { rmp_profiled_request_id: request_id, **record.to_h, created_at: timestamp, updated_at: timestamp }
          end
          Trace.insert_all(inserts)
        end
      end
    end
  end
end
