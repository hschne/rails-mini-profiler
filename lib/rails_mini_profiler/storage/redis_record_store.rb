# frozen_string_literal: true

module RailsMiniProfiler
  module Storage
    class RedisRecordStore < RecordStore
      DEFAULT_EXPIRATION = 60 * 60 * 24

      def initialize(record_type, configuration = nil)
        super
        @prefix = @storage_options[:prefix] || 'rmp'
        @redis = @storage_options[:redis] || StorageClient.create
        @expiration = @storage_options[:expiration] || DEFAULT_EXPIRATION
      end

      def all
        keys = @redis.smembers(record_index_key).map(&:to_i).map { |id| record_key(id) }
        return [] if keys.empty?

        @redis.mget(*keys)
          .map { |json| JSON.parse(json) }
          .map { |hash| @record_type.new(**hash) }
      end

      def find(id)
        result = @redis.get(record_key(id))
        raise(RecordNotFound, "Record with id='#{id}' not found") unless result

        json = JSON.parse(result)
        @record_type.new(**json)
      end

      def find_many(*ids)
        keys = (@redis.smembers(record_index_key).map(&:to_i) & ids).map { |id| record_key(id) }
        return [] if keys.empty?

        @redis.mget(*keys)
          .map { |json| JSON.parse(json) }
          .map { |hash| @record_type.new(**hash) }
      end

      def create(record)
        record.id = record_id.to_i
        @redis.set(record_key(record.id), record.to_json)
        @redis.sadd(record_index_key, record.id)

        record
      end

      def update(record)
        @redis.set(record_key(record.id), record.to_json)

        record
      end

      def destroy(id)
        @redis.del(record_key(id))
        @redis.srem(record_index_key, id)
        id
      end

      def clear
        keys = @redis.smembers(record_index_key).map { |id| record_key(id) }
        @redis.del(*keys) if keys.present?
        @redis.del(record_index_key)
        @redis.del(id_counter_key)
      end

      private

      def create_redis(options)
        require 'redis' unless defined? Redis
        Redis.new(options)
      end

      def record_id
        @redis.incr(id_counter_key)
      end

      def id_counter_key
        "#{@prefix}:#{@record_prefix}:next-id"
      end

      def record_index_key
        "#{@prefix}:#{@record_prefix}:record-ids"
      end

      def record_key(id)
        "#{@prefix}:#{@record_prefix}:#{id}"
      end
    end
  end
end
