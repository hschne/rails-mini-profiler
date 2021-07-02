# frozen_string_literal: true

module RailsMiniProfiler
  module Repositories
    module Memory
      class ProfiledRequestRepository < Repositories::ProfiledRequestRepository
        def initialize(user, memory_store = Storage::MemoryStore.get(ProfiledRequest))
          super(user)
          @request_store = memory_store
        end

        def all
          @request_store.all
            .select { |item| item.user_id = @user_id }
            .reverse
        end

        def find(id)
          @request_store.find(id)
        end

        def find_by(**kwargs)
          path = kwargs.delete(:path)
          result = all.select { |record| kwargs.all? { |k, v| record.public_send(k) == v } }
          result = result.select { |record| record.request_path =~ /#{Regexp.escape(path)}/ } if path
          result
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
