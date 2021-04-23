# frozen_string_literal: true

module RailsMiniProfiler
  class Response
    attr_reader :status, :headers, :response

    def initialize(status, headers, response)
      @status = status
      @headers = headers
      @response = response
    end
  end
end
