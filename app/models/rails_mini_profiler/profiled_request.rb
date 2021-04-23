module RailsMiniProfiler
  class ProfiledRequest
    include ActiveModel::Model

    attr_accessor :id,
                  :status,
                  :duration,
                  :path

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
