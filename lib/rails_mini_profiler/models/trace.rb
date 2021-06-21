# frozen_string_literal: true

module RailsMiniProfiler
  module Models
    class Trace
      include ActiveModel::Model

      attr_reader :name, :start, :finish, :duration, :payload, :backtrace, :allocations

      def initialize(**kwargs)
        kwargs.each { |key, value| instance_variable_set("@#{key}", value) }
      end
    end
  end
end
