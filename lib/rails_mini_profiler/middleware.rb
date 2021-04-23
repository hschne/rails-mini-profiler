# frozen_string_literal: true

module RailsMiniProfiler
  class Middleware
    def initialize(app)
      @app = app
      @configuration = RailsMiniProfiler.configuration
      @execution_context = ExecutionContext.instance(@configuration)
    end

    def call(env)
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
      record = Record.from(request_context)
      storage_instance = @execution_context.storage_instance
      storage_instance.save(record)

      Rails.logger.info(storage_instance.records)
    end
  end
end
