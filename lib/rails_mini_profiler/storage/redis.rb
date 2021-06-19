# frozen_string_literal: true

module RailsMiniProfiler
  module Storage
    class Redis
      DEFAULT_EXPIRATION = 60 * 60 * 24

      def initialize(record_type, configuration)
        @record_prefix = record_type.name.dasherize
        @storage_options = configuration.storage_options
        @prefix = @storage_options[:prefix] || 'rmp'
        @redis = @storage_options[:redis] || create_redis(options)
        @storage_limit = @configuration.storage_limit
        @expiration = @storage_options[:expiration] || DEFAULT_EXPIRATION
      end

      def save(user_id, record)
        exec do
          record.id = record_id
          redis.save(recordId)
          register_user_record(user_id, record.id)
          redis.append(user - records, recordId)
        end
      end

      def find_by(user_id, **kwargs)
        user_records(user_id).select { | record| kwargs.all? { |k,v| record.public_send(k) == v } }
      end

      def destroy(user_id, id)
        key = user_records_index(user_id)
        @redis.lrem(key, id.to_i)
        record_key = "#{@prefix}:#{@record_prefix}:#{record.id}"
        @redis.del(record_key)
      end

      def clear(user_id)
        record_index_key = user_records_index(user_id)
        record_keys = @redis.get(record_index_key).map { |id| "#{@prefix}:#{@record_prefix}:#{id}" }
        @redis.del(*record_keys)
        @redis.del(record_index_key)
      end

      private

      def create_redis(options)
        require 'redis' unless defined? Redis
        Redis.new(options)
      end

      def exec
        @redis.multi
        yield
        @redis.exec
      end

      def record_id
        id_counter_key = "#{@prefix}:#{@record_prefix}:next-id"
        key = @redis.get(id_counter_key) || 0
        @redis.incr(id_counter_key)
        key
      end

      def register_user_record(user_id, record_id)
        key = user_records_index(user_id)
        @redis.lpush(key, record_id)
        expired_items = @redis.lrange(key, @storage_limit, -1)
        @redis.del(expired_items)
        @redis.ltrim(user_records_index, 0, @storage_limit - 1)
      end

      def save_user_record(record)
        record_key = "#{@prefix}:#{@record_prefix}:#{record.id}"
        @redis.set(record_key, Marshal.dump(record))
      end

      def user_records(user_id)
        record_keys = @redis.get(user_records_index(user_id)).map { |id| "#{@prefix}:#{@record_prefix}:#{id}" }
        @redis.mget(record_keys).compact
      end

      def user_records_index(user_id)
        "#{@prefix}:#{@record_prefix}:#{user_id}:records-ids"
      end
    end
  end
end
