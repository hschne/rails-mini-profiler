# frozen_string_literal: true

module RailsMiniProfiler
  class ResponseWrapper
    attr_reader :response, :rack_response

    delegate :status, :headers, to: :rack_response

    def initialize(status, headers, response)
      @rack_response = Rack::Response.new(response, status, headers)
      @response = response
    end

    def body
      response&.body || {}
    end

    def media_type
      @media_type ||= @rack_response.media_type
    end
  end
end
