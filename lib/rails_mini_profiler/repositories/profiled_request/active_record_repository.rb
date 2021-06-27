# frozen_string_literal: true

module RailsMiniProfiler
  module Repositories
    module ProfiledRequest
      class ActiveRecordRepository < ProfiledRequestRepository
        def initialize(user)
          super
          @request_store = Storage::ActiveRecordStore.new(ProfiledRequest)
          @trace_store = Storage::ActiveRecordStore.new(Trace)
          @storage_limit = RailsMiniProfiler.storage_configuration.max_size
        end

        def all
          @request_store.all
        end

        def find(id)
          @request_store.find(id)
        end

        def find_by(**kwargs)
          all.where(**kwargs)
        end

        def create(request)
          ActiveRecord::Base.transaction do
            request.traces.each { |trace| @trace_store.create(trace) }
            @request_store.create(request)
          end
        end

        def update(request)
          @request_store.update(request)
        end

        def destroy(request_id)
          @request_store.destroy(request_id)
        end

        def clear
          all.destroy_all
        end
      end
    end
  end
end
