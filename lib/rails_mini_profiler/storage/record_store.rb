# frozen_string_literal: true

module RailsMiniProfiler
  module Storage
    class RecordStore
      class << self
        def get(record_type)
          configuration = RailsMiniProfiler.configuration
          storage_type = configuration.storage.name.demodulize
          @registry ||= {}
          @registry[storage_type] ||= {}
          @registry[storage_type][record_type] ||= create_record_store(storage_type, record_type)
        end

        private

        def create_record_store(storage_type, record_type)
          clazz = "RailsMiniProfiler::Storage::#{storage_type}Store".constantize
          clazz.new(record_type)
        end
      end

      def initialize(record_type, configuration)
        @record_type = record_type
        configuration ||= RailsMiniProfiler.configuration
        @storage_options = configuration.storage.configuration
      end

      def all
        raise(NotImplementedError)
      end

      def find(id)
        raise(NotImplementedError)
      end

      def find_many(*ids)
        raise(NotImplementedError)
      end

      def create(record)
        raise(NotImplementedError)
      end

      def update(record)
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
