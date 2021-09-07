module RailsMiniProfiler
  module Tracing
    class ViewTrace < Trace
      def ignore?
        !SqlTracker.new(name: payload[:name], query: payload[:sql]).track?
      end

      def transform!
        @event.payload.slice(:identifier, :count)
      end
    end
  end
end
