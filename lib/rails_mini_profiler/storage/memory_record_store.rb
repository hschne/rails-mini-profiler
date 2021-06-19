# frozen_string_literal: true

module RailsMiniProfiler
  module Storage
    class MemoryRecordStore < RecordStore
      def initialize(record_type, configuration = nil)
        super
        @lock = Mutex.new
        @id = 1
        @records = {}
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
