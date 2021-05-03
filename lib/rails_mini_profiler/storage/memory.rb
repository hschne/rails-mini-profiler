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
          record.id = @id
          @records[@id] = record
          @id += 1
        end
        record
      end

      def all
        @records.values
      end

      def all_for_user(user)
        @records.values.select { |record| record.user = user }
      end

      def find(id)
        @records[id.to_i]
      end


      def destroy(id)
        @records.delete(id.to_i)
      end

      def clear
        @records.clear
      end
    end
  end
end
