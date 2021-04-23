# frozen_string_literal: true

module RailsMiniProfiler
  class MiddlewareLogger
    def initialize(app)
      @app = app
    end

    def call(env)
      request_started_on = Time.now
      @status, @headers, @response = @app.call(env)
      request_ended_on = Time.now

      Rails.logger.info '=' * 50
      Rails.logger.info "Request delta time: #{request_ended_on - request_started_on} seconds."
      Rails.logger.info '=' * 50

      [@status, @headers, @response]
    end
  end
end
