# frozen_string_literal: true

module RailsMiniProfiler
  class Middleware
    def initialize(app)
      @app = app
      @context = RailsMiniProfiler.context
    end

    def call(env)
      request = Request.new(env)
      return @app.call(env) unless Guard.new(request).profile?

      request_context = RequestContext.new(Request.new(env))
      request_context.start_time = Process.clock_gettime(Process::CLOCK_MONOTONIC)
      status, headers, response = @app.call(env)
      request_context.end_time = Process.clock_gettime(Process::CLOCK_MONOTONIC)

      request_context.response = Response.new(status, headers, response)

      save(request_context)
      [status, headers, response]
    end

    private

    def save(request_context)
      record = ProfiledRequest.from(request_context)
      storage_instance = @context.storage_instance
      storage_instance.save(record)
    end
  end
end
