# frozen_string_literal: true

module RailsMiniProfiler
  class Record
    attr_reader :id,
                :status,
                :duration,
                :path

    def initialize(**kwargs)
      @duration = kwargs[:duration]
      @status = kwargs[:status]
      @path = kwargs[:path]
    end

    class << self
      def from(request_context)
        kwargs = {
          duration: (request_context.end_time - request_context.start_time) * 1000,
          status: request_context.response.status,
          path: request_context.request.path
        }
        new(**kwargs)
      end
    end
  end
end
