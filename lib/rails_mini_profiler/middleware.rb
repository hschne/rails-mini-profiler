# frozen_string_literal: true

module RailsMiniProfiler
  class Middleware
    def initialize(app)
      @app = app
      @context = RailsMiniProfiler.context
      Tracers.setup! { |trace| track_trace(trace) }
    end

    def call(env)
      request = Request.new(env)
      request_context = RequestContext.new(@context, request)
      return @app.call(env) unless Guard.new(request_context).profile?

      self.profiled_request = ProfiledRequest.new(request: request)
      status, headers, response = profile(request)
      return [status, headers, response] if request_context.authorized?

      profiled_request.response = Response.new(status: status, headers: headers, response: response)
      profiled_request.user = request_context.user
      save_request!

      result = render_response(request)
      self.profiled_request = nil
      result
    end

    def profiled_request
      Thread.current[:rails_mini_profiler_current_request]
    end

    def profiled_request=(profiled_request)
      Thread.current[:rails_mini_profiler_current_request] = profiled_request
    end

    def track_trace(trace)
      return if profiled_request.nil?

      profiled_request.traces.append(trace)
    end

    private

    def render_response(request)
      redirect = Redirect.new(request, profiled_request).render
      return redirect if redirect

      response = Badge.new(profiled_request).render
      [response.status, response.headers, response.response]
    end

    def profile(request)
      ActiveSupport::Notifications.instrument('rails_mini_profiler.total_time') do
        Flamegraph.new(request).record(profiled_request) { @app.call(request.env) }
      end
    end

    def save_request!
      profiled_request.complete!

      storage_instance = @context.storage_instance
      storage_instance.save(profiled_request)
    end
  end
end
