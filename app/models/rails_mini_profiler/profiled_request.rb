# frozen_string_literal: true

module RailsMiniProfiler
  class ProfiledRequest
    include ActiveModel::Model

    attr_accessor :id,
                  :status,
                  :duration,
                  :path,
                  :headers,
                  :body,
                  :traces

    class << self
      def from(request_context)
        kwargs = {
          duration: ((request_context.end_time - request_context.start_time) * 1000).round(3),
          status: request_context.response.status,
          path: request_context.request.path,
          traces: request_context.traces
        }
        new(**kwargs)
      end
    end
  end
end
