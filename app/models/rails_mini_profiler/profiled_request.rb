# frozen_string_literal: true

module RailsMiniProfiler
  class ProfiledRequest
    include ActiveModel::Model

    attr_accessor :id,
                  :status,
                  :start,
                  :finish,
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
        total_time = request_context.traces.find { |trace| trace.name == 'rails_mini_profiler.total_time' }
        kwargs = {
          status: request_context.response.status,
          start: total_time&.start,
          finish: total_time&.finish,
          duration: ((total_time.finish - total_time.start) * 1000).round(2),
          path: request_context.request.path,
          traces: request_context.traces
        }
        new(**kwargs)
      end
    end
  end
end
