# frozen_string_literal: true

module RailsMiniProfiler
  module Repositories
    module ActiveRecord
      class ProfiledRequestRepository < Repositories::ProfiledRequestRepository
        def initialize(user_id)
          super
        end

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
            attributes = request.to_h
                           .except('traces', 'flamegraph')
                           .merge(user_id: @user_id)
            profiled_request = ProfiledRequest.create(attributes)
            Flamegraph.create(profiled_request: profiled_request, data: request.flamegraph.data)
            ActiveRecord::TraceRepository.new(profiled_request.id).insert_all(request.traces)
            profiled_request
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
      end
    end
  end
end
