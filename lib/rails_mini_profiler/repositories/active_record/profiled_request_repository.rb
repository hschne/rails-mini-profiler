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
          profiled_request = RailsMiniProfiler::ProfiledRequest.new
          attributes = request.to_h
                         .except('traces', 'flamegraph')
                         .merge(user_id: @user_id)
          profiled_request.assign_attributes(attributes)
          if request.flamegraph
            profiled_request.flamegraph = Flamegraph.new(profiled_request: profiled_request, data: request.flamegraph.data)
          end
          request.traces.each do |trace|
            profiled_request.traces.build(profiled_request: profiled_request, **trace.to_h)
          end
          profiled_request.save!
          profiled_request
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

        def trace_repository(request_id)
          @trace_repository ||= TraceRepository.get(request_id)
        end
      end
    end
  end
end
