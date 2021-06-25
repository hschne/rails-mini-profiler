# frozen_string_literal: true

module RailsMiniProfiler
  module Storage
    class StorageClient
      private_class_method :new

      class << self
        def create
          storage_client
        end

        private

        def storage_client
          @storage_client[@storage_type] ||= begin
            configuration = RailsMiniProfiler.configuration
            storage_options = configuration.storage.configuration
            new(storage_type, storage_options).create_storage_client
          end
        end
      end

      def initialize(storage_type, storage_options)
        @storage_type = storage_type
        @storage_options = storage_options
      end

      def create_storage_client
        case @storage_type
        when :redis
          create_redis_client
        else
          raise(StorageError, "Cannot create a client for storage type #{@storage_type}")
        end
      end

      private

      def create_redis_client
        require 'redis' unless defined? Redis
        Redis.new(@storage_options)
      end
    end
  end
end
