# frozen_string_literal: true

module RailsMiniProfiler
  module Tracing
    class ViewTrace < Trace
      def ignore?
        !SqlTracker.new(name: payload[:name], query: payload[:sql]).track?
      end

      def transform!
        @payload.slice!(:identifier, :count)
      end
    end
  end
end
