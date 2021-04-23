# frozen_string_literal: true

module RailsMiniProfiler
  class RequestContext
    attr_reader :request, :traces

    attr_accessor :response

    def initialize(request = nil)
      @request = request
      @traces = []
    end
  end
end
