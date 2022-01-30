# frozen_string_literal: true

module RailsMiniProfiler
  # A convenience wrapper extending {Rack::Request}
  #
  # @api private
  class RequestWrapper < Rack::Request
    # Convenience method to read the request body as String
    #
    # @return [String] the request body
    def body
      return '' unless super

      body = super.read
      super.rewind
      body
    end

    # The request headers
    #
    # @return [Hash] the request headers
    def headers
      env.select { |k, _v| k.start_with? 'HTTP_' } || {}
    end
  end
end
