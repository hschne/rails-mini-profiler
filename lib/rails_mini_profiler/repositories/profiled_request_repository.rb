# frozen_string_literal: true

module RailsMiniProfiler
  module Repositories
    class ProfiledRequestRepository
      class << self
        def get(user_id)
          create_repository(user_id)
        end

        def create_repository(user_id)
          storage_type = RailsMiniProfiler.configuration.storage.to_sym
          clazz = "#{module_parent}::ProfiledRequest::#{storage_type.capitalize}Repository".constantize
          return clazz.new(user_id) unless storage_type == :memory

          # For the memory storage its just simpler to retain a repository per user in memory. Each user keeps their own
          # records in an individual hash.
          @repositories ||= {}
          @repositories[user_id] ||= clazz.new(user_id)
        end
      end

      def initialize(user_id)
        @request_store = Storage::RecordStore.get(ProfiledRequest)
        @user_id = user_id
      end

      def all
        raise(NotImplementedError)
      end

      def find(id)
        raise(NotImplementedError)
      end

      def find_by(**kwargs)
        raise(NotImplementedError)
      end

      def create(request)
        raise(NotImplementedError)
      end

      def update(request)
        raise(NotImplementedError)
      end

      def destroy(id)
        raise(NotImplementedError)
      end

      def clear
        raise(NotImplementedError)
      end
    end
  end
end
