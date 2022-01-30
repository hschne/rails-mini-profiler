# frozen_string_literal: true

module RailsMiniProfiler
  class Middleware
    def initialize(app)
      @app = app
      @config = RailsMiniProfiler.configuration
      @registry = Tracers::Registry.setup!(@config)
      Tracers::Subscriptions.setup!(@registry.tracers.keys) { |trace| track_trace(trace) }
      @trace_factory = Tracers::TraceFactory.new(@registry)
    end

    def call(env)
      request = RequestWrapper.new(env)
      request_context = RequestContext.new(request)
      return @app.call(env) unless Guard.new(request_context).profile?

      result = with_tracing(request_context) { profile(request_context) }
      return result unless request_context.authorized?

      status, headers, body = result
      request_context.response = ResponseWrapper.new(body, status, headers)
      complete!(request_context)
      request_context.saved? ? render_response(request_context).to_a : result
    ensure
      User.current_user = nil
    end

    def traces
      Thread.current[:rails_mini_profiler_traces]
    end

    def traces=(traces)
      Thread.current[:rails_mini_profiler_traces] = traces
    end

    def track_trace(event)
      return if traces.nil?

      trace = @trace_factory.create(event)
      traces.append(trace) unless trace.is_a?(RailsMiniProfiler::Tracers::NullTrace)
    end

    private

    def complete!(request_context)
      request_context.save_results!
      true
    rescue ActiveRecord::ActiveRecordError => e
      RailsMiniProfiler.logger.error("Could not save profile: #{e}")
      false
    end

    def render_response(request_context)
      redirect = Redirect.new(request_context).render
      return redirect if redirect

      Badge.new(request_context).render
    end

    def profile(request_context)
      ActiveSupport::Notifications.instrument('rails_mini_profiler.total_time') do
        request = request_context.request
        FlamegraphGuard.new(request_context).record { @app.call(request.env) }
      end
    end

    def with_tracing(request_context)
      self.traces = []
      result = yield
      request_context.traces = traces
      self.traces = nil
      result
    end
  end
end
