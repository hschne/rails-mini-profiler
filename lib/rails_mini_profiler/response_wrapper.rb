# frozen_string_literal: true

module RailsMiniProfiler
  class ResponseWrapper
    attr_reader :status, :headers, :response

    def initialize(status = nil, headers = nil, response = nil)
      @status = status
      @headers = headers
      @response = response
    end

    def body
      response&.body || {}
    end
  end
end
