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

      self.profiled_request = Models::ProfiledRequest.new
      profiled_request.request = request
      result = profile(request)
      return result if request_context.authorized?

      save_request(request_context, result)

      result = render_response(request, result)
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

    def save_request(request_context, result)
      status, headers, response = result
      profiled_request.response = Response.new(status: status, headers: headers, response: response)
      profiled_request.user_id = request_context.user_id
      Repositories::ProfiledRequestRepository.get(request_context.user_id).create(profiled_request)
    end

    def render_response(request, result)
      redirect = Redirect.new(request, profiled_request).render
      return redirect if redirect

      status, headers, response = result
      original_response = Response.new(status: status,
                                       headers: headers,
                                       response: response)
      modified_response = Badge.new(profiled_request, original_response).render
      [modified_response.status, modified_response.headers, modified_response.response]
    end

    def profile(request)
      ActiveSupport::Notifications.instrument('rails_mini_profiler.total_time') do
        Flamegraph.new(request).record(profiled_request) { @app.call(request.env) }
      end
    end
  end
end
