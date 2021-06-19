# frozen_string_literal: true

module RailsMiniProfiler
  module Storage
    class Memory
      def initialize(_record_type, _configuration)
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

      def all_for_user(user)
        @records.values.select { |record| record.user = user }
      end

      def find(id)
        result = @records[id.to_i]
        raise(RecordNotFound, "Record with id='#{id}' found") unless result


        result
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
