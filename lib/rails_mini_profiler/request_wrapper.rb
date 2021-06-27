# frozen_string_literal: true

module RailsMiniProfiler
  class RequestWrapper
    attr_reader :env

    def initialize(env = {})
      @env = env
    end

    def method
      @env['REQUEST_METHOD']
    end

    def headers
      @env.select { |k, _v| k.start_with? 'HTTP_' }
    end

    def query_string
      @env['QUERY_STRING']
    end

    def path
      # Some requests do not have request path set, we fall back to path info
      @env['PATH_INFO']
    end

    def body
      @env['rack.input']&.read
    end

    private

    def sanitize_headers(headers)
      headers.collect { |k, v| [k.sub(/^HTTP_/, ''), v] }.collect do |k, v|
        [k.split('_').collect(&:capitalize).join('-').to_sym, v]
      end
    end
  end
end
