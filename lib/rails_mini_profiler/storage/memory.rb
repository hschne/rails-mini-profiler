# frozen_string_literal: true

module RailsMiniProfiler
  module Storage
    class Memory
      def initialize
        @lock = Mutex.new
        @id = 1
        @records = {}
      end

      def save(record)
        @lock.synchronize do
          @records[@id] = record
          @id += 1
        end
        record
      end

      def all
        @records.keys
      end

      def find(id)
        @records[id]
      end

      def destroy(id)
        @records.delete(id)
      end
    end
  end
end
