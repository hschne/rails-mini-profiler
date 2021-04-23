# frozen_string_literal: true

module RailsMiniProfiler
  class RequestContext
    extend Forwardable

    attr_reader :request

    attr_accessor :response, :start_time, :end_time

    def initialize(request)
      @request = request
    end
  end
end
