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

    def initialize(attributes = nil)
      super
      @status ||= 200
      @duration ||= 0
      @traces ||= []
    end

    class << self
      def from(request_context)
        kwargs = {
          status: request_context.response.status,
          path: request_context.request.path,
          traces: request_context.traces
        }
        new(**kwargs)
      end
    end
  end
end
