# frozen_string_literal: true

module RailsMiniProfiler
  module Repositories
    module ProfiledRequest
      class MemoryRepository < ProfiledRequestRepository
        def initialize(user)
          super
          @request_store = Storage::MemoryStore.new(ProfiledRequest)
          @storage_limit = RailsMiniProfiler.storage_configuration.max_size
        end

        def all
          @request_store.all
        end

        def find(id)
          @request_store.find(id)
        end

        def find_by(**kwargs)
          all.select { |record| kwargs.all? { |k, v| record.public_send(k) == v } }
        end

        def create(request)
          @request_store.create(request)
        end

        def update(request)
          @request_store.update(request)
        end

        def destroy(request_id)
          @request_store.destroy(request_id)
        end

        def clear
          @request_store.clear
        end
      end
    end
  end
end
