# frozen_string_literal: true

module RailsMiniProfiler
  class Middleware
    def initialize(app)
      @app = app
      @context = RailsMiniProfiler.context
      subscribe_to_default
    end

    DEFAULT_SUBSCRIPTIONS = %w[
      sql.active_record
      render_template.action_view
      render_partial.action_view
      process_action.action_controller
      rails_mini_profiler.total_time
    ].freeze

    def call(env)
      request = Request.new(env)
      return @app.call(env) unless Guard.new(request).profile?

      self.request_context = RequestContext.new(Request.new(env))
      status, headers, response = ActiveSupport::Notifications.instrument('rails_mini_profiler.total_time') do
        @app.call(env)
      end
      request_context.response = Response.new(status, headers, response)

      save(request_context)
      [status, headers, response]
    end

    def request_context
      Thread.current[:rails_mini_profiler_request_context]
    end

    def request_context=(request_context)
      Thread.current[:rails_mini_profiler_request_context] = request_context
    end

    def track_trace(trace)
      return if request_context.nil?

      request_context.traces.prepend(trace)
    end

    private

    def save(request_context)
      record = ProfiledRequest.from(request_context)
      storage_instance = @context.storage_instance
      storage_instance.save(record)
    end

    def subscribe_to_default
      DEFAULT_SUBSCRIPTIONS.each do |event|
        subscribe(event)
      end
    end

    def subscribe(*subscriptions)
      subscriptions.each do |subscription|
        ActiveSupport::Notifications.monotonic_subscribe(subscription) do |name, start, finish, id, payload|
          trace = Trace.new(
            id: id,
            name: name,
            start: start.to_f,
            finish: finish.to_f,
            duration: ((finish - start) * 1000).round(2),
            backtrace: Rails.backtrace_cleaner.clean(caller),
            payload: payload
          )
          track_trace(trace)
        end
      end
    end
  end
end
