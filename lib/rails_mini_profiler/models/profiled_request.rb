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
                    :request_method,
                    :response_status,
                    :response_body,
                    :response_headers,
                    :request_headers,
                    :request_body,
                    :request_path,
                    :flamegraph,
                    :traces,
                    :created_at

      def initialize(**kwargs)
        super(**kwargs)
        @duration = 0
        @created_at = Time.zone.now
        @traces ||= []
      end

      def request=(request)
        @request_body = request.body || ''
        @request_method = request.method || 'GET'
        @request_path = request.path || ''
        @request_headers = request.headers || []
      end

      def response=(response)
        @response_body = ''
        @response_headers = response.headers || ''
        @response_status = response.status || 200
      end

      def complete!
        total_time = traces.find { |trace| trace.name == 'rails_mini_profiler.total_time' }
        traces.delete(total_time)
        @start = total_time.start
        @finish = total_time.finish
        @duration = total_time.duration
        @allocations = total_time.allocations
        @created_at = Time.zone.now
      end
    end
  end
end
