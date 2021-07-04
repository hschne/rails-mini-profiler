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
    end
  end
end
