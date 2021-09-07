# frozen_string_literal: true

module RailsMiniProfiler
  module Tracing
    class ControllerTrace < Trace
      def transform!
        payload = @payload
                    .slice(:view_runtime, :db_runtime)
                    .transform_values { |value| value&.round(2) }
        payload.reject { |_k, v| v.blank? }
        @payload = payload
      end
    end
  end
end
