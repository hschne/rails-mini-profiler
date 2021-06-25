# frozen_string_literal: true

module RailsMiniProfiler
  module Storage
    class ActiveRecord < BaseStorage
      class << self
        def configuration
          @configuration ||= ActiveRecord.new
        end
      end

      attr_accessor :profiled_request_table, :trace_table, :flamegraph_table

      def defaults!
        super
        @profiled_request_table = 'profiled_requests'
        @flamegraph_table = 'flamegraphs'
        @trace_table = 'traces'
      end
    end
  end
end
