# frozen_string_literal: true

module RailsMiniProfiler
  module Tracers
    # Subscribe to application events. This is used during engine startup.
    # @api private
    class Subscriptions
      class << self
        # Subscribe to each individual active support event using a callback.
        def setup!(subscriptions, &callback)
          subscriptions.each do |event|
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
