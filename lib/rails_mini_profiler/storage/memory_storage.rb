# frozen_string_literal: true

module Storage
  class MemoryStorage
    class << self
      def configure
        yield(configuration)
      end

      private

      def configuration
        @configuration ||= ActiveRecordStorage.new
      end
    end

    attr_accessor :profiled_request_table, :trace_table, :flamegraph_table
  end
end
