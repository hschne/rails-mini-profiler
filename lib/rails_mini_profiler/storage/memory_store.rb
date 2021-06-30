# frozen_string_literal: true

module RailsMiniProfiler
  module Storage
    class MemoryStore
      class << self
        def get(record_type)
          registry[record_type] ||= new
        end

        def reset
          registry.each_value(&:clear)
        end

        private

        def registry
          @registry ||= {}
        end
      end

      def initialize(records = {})
        super()
        @lock = Mutex.new
        @records = records
        @id = records.size + 1
      end

      def all
        @records.values
      end

      def find(id)
        result = @records[id.to_i]
        raise(RecordNotFound, "Record with id='#{id}' found") unless result

        result
      end

      def find_many(*ids)
        @records.values_at(*ids).compact
      end

      def create(record)
        @lock.synchronize do
          record.id = @id
          @records[@id] = record
          @id += 1
        end
        record
      end

      def update(record)
        @records[record.id] = record

        record
      end

      def destroy(id)
        @records.delete(id)
      end

      def clear
        @records.clear
      end
    end
  end
end
