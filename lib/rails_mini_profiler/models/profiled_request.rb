# frozen_string_literal: true

module RailsMiniProfiler
  module Models
    class ProfiledRequest < BaseModel
      attr_accessor :id,
                    :user_id,
                    :start,
                    :finish,
                    :duration,
                    :allocations,
                    :response_status,
                    :response_body,
                    :response_headers,
                    :request_headers,
                    :request_body,
                    :request_path,
                    :flamegraph,
                    :traces

      def initialize(**kwargs)
        super(**kwargs)
        @traces ||= []
      end

      def request=(request)
        @request_body = request.body
        @request_path = request.path
        @request_headers = request.headers
      end

      def response=(response)
        @response_body = response.body
        @response_headers = response.headers
        @response_status = response.status
      end

      def complete!
        total_time = traces.find { |trace| trace.name == 'rails_mini_profiler.total_time' }
        traces.delete_at(0)
        @start = total_time.start
        @finish = total_time.finish
        @duration = total_time.duration
        @allocations = total_time.allocations
      end
    end
  end
end
