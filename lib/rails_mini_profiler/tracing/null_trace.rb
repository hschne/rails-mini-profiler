# frozen_string_literal: true

module RailsMiniProfiler
  module Tracing
    class NullTrace < Trace

    end

    def is_null?
      true
    end
  end
end
