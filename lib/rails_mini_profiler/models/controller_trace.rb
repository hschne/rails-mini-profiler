# frozen_string_literal: true

module RailsMiniProfiler
  module Models
    class ControllerTrace < Trace
      def db_runtime
        payload[:db_runtime]
      end
    end
  end
end
