# frozen_string_literal: true

module RailsMiniProfiler
  module Storage
    class Memory
      attr_reader :records

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
      end
    end
  end
end
