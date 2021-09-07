# frozen_string_literal: true

module RailsMiniProfiler
  module Tracing
    class Subscriptions
      DEFAULT_SUBSCRIPTIONS = %w[
        sql.active_record
        instantiation.active_record
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

        private

        def subscribe(*subscriptions, &callback)
          subscriptions.each do |subscription|
            ActiveSupport::Notifications.subscribe(subscription) do |event|
              callback.call(event)
            end
          end
        end
      end
    end
  end
end
