# frozen_string_literal: true

module RailsMiniProfiler
  module Models
    class QueryTrace < Trace
      def sql
        payload[:sql]
      end
    end
  end
end
