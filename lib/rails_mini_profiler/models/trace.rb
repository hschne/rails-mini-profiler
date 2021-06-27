# frozen_string_literal: true

module RailsMiniProfiler
  module Models
    class Trace < BaseModel
      attr_accessor :name, :start, :finish, :duration, :payload, :backtrace, :allocations

      def initialize(**attributes)
        super
        sanitize_payload!
      end

      def sanitize_payload!
        @payload = payload.slice(:sql, :name, :binds, :statement_name)
      end
    end
  end
end
