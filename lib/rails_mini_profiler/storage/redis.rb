# frozen_string_literal: true

module RailsMiniProfiler
  module Storage
    class Redis
      DEFAULT_EXPIRATION = 60 * 60 * 24

      def initialize(record_type, configuration)
        @record_type = record_type
        @record_prefix = @record_type.name.underscore.dasherize
        @storage_options = configuration.storage_options
        @prefix = @storage_options[:prefix] || 'rmp'
        @redis = @storage_options[:redis] || create_redis(options)
        @storage_limit = configuration.storage_limit
        @expiration = @storage_options[:expiration] || DEFAULT_EXPIRATION
      end

      def save(user_id, record)
        record.id = record_id
        register_user_record(user_id, record.id)
        save_user_record(record)

        record
      end

      def find(id)
        record_key = "#{@prefix}:#{@record_prefix}:#{id}"
        json = JSON.parse(@redis.get(record_key))
        @record_type.new(**json)
      end

      def find_by(user_id, **kwargs)
        user_records(user_id)
          .map { |record| JSON.parse(record) }
          .map { |hash| @record_type.new(hash) }
          .select { |record| kwargs.all? { |k, v| record.public_send(k) == v } }
      end

      def destroy(user_id, id)
        key = user_records_index(user_id)
        @redis.lrem(key, -1, id.to_i)
        record_key = "#{@prefix}:#{@record_prefix}:#{id}"
        @redis.del(record_key)
        id
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
        @redis.incr(id_counter_key)
        @redis.get(id_counter_key)
      end

      def register_user_record(user_id, record_id)
        key = user_records_index(user_id)
        @redis.lpush(key, record_id)
        expired_items = @redis.lrange(key, @storage_limit, -1)
        return if expired_items.empty?

        @redis.del(expired_items)
        @redis.ltrim(user_records_index(user_id), 0, @storage_limit - 1)
      end

      def save_user_record(record)
        record_key = "#{@prefix}:#{@record_prefix}:#{record.id}"
        @redis.set(record_key, record.to_json)
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
