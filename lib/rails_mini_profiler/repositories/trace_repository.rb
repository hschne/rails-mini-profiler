# frozen_string_literal: true

module RailsMiniProfiler
  module Repositories
    class TraceRepository
      class << self
        def get(request_id)
          create_repository(request_id)
        end

        def create_repository(request_id)
          storage = RailsMiniProfiler.configuration.storage
          storage_type = storage.name.demodulize
          clazz = "#{module_parent}::#{storage_type}::TraceRepository".constantize
          return clazz.new(request_id) unless storage.to_sym == :memory

          @repositories ||= {}
          @repositories[request_id] ||= clazz.new(request_id)
        end
      end

      def initialize(request_id)
        @request_id = request_id
      end

      def all
        raise(NotImplementedError)
      end

      def find_by(**kwargs)
        raise(NotImplementedError)
      end

      def create(request)
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
