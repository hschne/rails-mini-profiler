# frozen_string_literal: true

module RailsMiniProfiler
  module Repositories
    class ProfiledRequestRepository
      class << self
        def get(user_id)
          create_repository(user_id)
        end

        def create_repository(user_id)
          storage = RailsMiniProfiler.configuration.storage
          storage_type = storage.name.demodulize
          clazz = "#{module_parent}::#{storage_type}::ProfiledRequestRepository".constantize
          @repositories ||= {}
          @repositories[clazz] ||= clazz.new(user_id)
        end
      end

      def initialize(user_id)
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
