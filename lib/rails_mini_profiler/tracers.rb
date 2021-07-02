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
            start = (event.time.to_f * 100_000).to_i
            finish = (event.end.to_f * 100_000).to_i
            trace = Models::Trace.new(
              name: event.name,
              start: start,
              finish: finish,
              duration: finish - start,
              allocations: event.allocations,
              backtrace: Rails.backtrace_cleaner.clean(caller),
              payload: format_payload(event)
            )
            callback.call(trace)
          end
        end
      end

      def format_payload(event)
        case event.name
        when 'sql.active_record'
          raw = event.payload.slice(:name, :sql, :binds, :type_casted_binds)
          raw[:binds] = transform_binds(raw[:binds], raw[:type_casted_binds])
          raw.delete(:type_casted_binds)
          raw.reject { |_k, v| v.blank? }
        when 'render_template.action_view', 'render_partial.action_view'
          event.payload.slice(:identifier, :count)
        when 'process_action.action_controller'
          event.payload.slice(:view_runtime, :db_runtime).transform_values { |value| value.round(2) }
        else
          {}
        end
      end

      def transform_binds(binds, type_casted_binds)
        binds.each_with_object([]).with_index do |(binding, object), i|
          name = binding.name
          value = type_casted_binds[i]
          object << { name: name, value: value }
        end
      end
    end
  end
end
