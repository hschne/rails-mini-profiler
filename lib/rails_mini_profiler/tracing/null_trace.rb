# frozen_string_literal: true

module RailsMiniProfiler
  module Tracing
    class NullTrace < Trace
      def ignore?
        true
      end
    end
  end
end
