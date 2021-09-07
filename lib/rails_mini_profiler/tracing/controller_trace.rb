module RailsMiniProfiler
  module Tracing
    class ControllerTrace < Trace

      def ignore?
        !SqlTracker.new(name: payload[:name], query: payload[:sql]).track?
      end

      def transform!
        transform_payload!
      end

      private

      def transform_payload!
        payload = event.payload
                    .slice(:view_runtime, :db_runtime)
                    .transform_values { |value| value&.round(2) }
        payload.reject { |_k, v| v.blank? }
        @payload = payload
      end
    end
  end
end
