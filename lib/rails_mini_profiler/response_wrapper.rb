# frozen_string_literal: true

module RailsMiniProfiler
  # A convenience wrapper extending {Rack::Response}
  #
  # @api private
  class ResponseWrapper < Rack::Response
    # Return the response body as String
    #
    # Depending on preceding middleware, response bodies may be Strings, Arrays or literally anything else. This method
    # converts whatever it is to a string so we can store it later.
    #
    # @return [String] of the response body
    def body
      body = super
      case body
      when String
        body
      when Array
        body.join
      when ActionDispatch::Response::RackBody
        body.body
      else
        ''
      end
    end

    def json?
      media_type =~ %r{application/json}
    end

    def xml?
      media_type =~ %r{application/xml}
    end
  end
end
