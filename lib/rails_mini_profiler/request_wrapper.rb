# frozen_string_literal: true

module RailsMiniProfiler
  # A convenience wrapper around [Rack::Env]
  #
  # @!attribute body
  #   @return [String] the request body
  # @!attribute method
  #   @return [String] the request method
  # @!attribute path
  #   @return [String] the request path
  # @!attribute query_string
  #   @return [String] the request query string
  # @!attribute env
  #   @return [Rack::Env] the original env
  #
  # @api private
  class RequestWrapper
    attr_reader :body,
                :method,
                :path,
                :query_string,
                :env

    def initialize(*_args, **attributes)
      @attributes = attributes
      setup
    end

    # The request headers
    #
    # @return [Hash] the headers
    def headers
      @attributes[:headers] || @env.select { |k, _v| k.start_with? 'HTTP_' } || {}
    end

    private

    def setup
      @env = @attributes[:env] || {}
      @method = setup_method
      @query_string = setup_query_string
      @path = setup_path
      @body = setup_body
    end

    def setup_method
      @attributes[:method] || @env['REQUEST_METHOD'] || 'GET'
    end

    def setup_query_string
      @attributes[:query_string] || @env['QUERY_STRING'] || ''
    end

    def setup_path
      @attributes[:path] || @env['PATH_INFO'] || '/'
    end

    def setup_body
      return @attributes[:body] if @attributes[:body]

      return '' unless @env['rack.input']

      body = @env['rack.input'].read
      @env['rack.input'].rewind
      body
    end
  end
end
