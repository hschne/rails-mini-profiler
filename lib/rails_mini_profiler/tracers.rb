# frozen_string_literal: true

module RailsMiniProfiler
  class Tracers
    DEFAULT_SUBSCRIPTIONS = %w[
      sql.active_record
      render_template.action_view
      render_partial.action_view
      process_action.action_controller
      rails_mini_profiler.total_time
    ].freeze

    class << self
      def setup!(&callback)
        DEFAULT_SUBSCRIPTIONS.each do |event|
          subscribe(event, &callback)
        end
      end

      def subscribe(*subscriptions, &callback)
        subscriptions.each do |subscription|
          ActiveSupport::Notifications.monotonic_subscribe(subscription) do |event|
            trace = Models::Trace.new(
              name: event.name,
              start: event.time.to_f,
              finish: event.end.to_f,
              duration: event.duration.to_f.round(2),
              allocations: event.allocations,
              backtrace: Rails.backtrace_cleaner.clean(caller),
              payload: event.payload
            )
            callback.call(trace)
          end
        end
      end
    end
  end
end
