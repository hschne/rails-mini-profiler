# frozen_string_literal: true

module RailsMiniProfiler
  class RedisProfiledRequestRepository < ProfiledRequestRepository

    def initialize(user)
      super
      @redis = Storage::StorageClient.create
      @storage_limit = RailsMiniProfiler.configuration.storage_limit
    end

    def all
      user_records
        .map { |record| JSON.parse(record) }
        .map { |hash| @record_type.new(hash) }
    end

    def find(id)
      @request_store.find(id)
    end

    def find_by(**kwargs)
      all.select { |record| kwargs.all? { |k, v| record.public_send(k) == v } }
    end

    def create(request)
      @redis.multi do
        record = @request_store.create(request)
        register_user_record(record)
        record
      end
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

    private

    def user_records_index
      "#{@prefix}:#{@record_prefix}:#{@user_id}:records-ids"
    end

    def user_records
      record_keys = @redis.get(user_records_index).map { |id| "#{@prefix}:#{@record_prefix}:#{id}" }
      @redis.mget(record_keys).compact
    end

    def register_user_record(record_id)
      @redis.lpush(user_records_index, record_id)
      expired_items = @redis.lrange(key, @storage_limit, -1)
      return if expired_items.empty?

      @redis.del(expired_items)
      @redis.ltrim(user_records_index, 0, @storage_limit - 1)
    end

  end
end
