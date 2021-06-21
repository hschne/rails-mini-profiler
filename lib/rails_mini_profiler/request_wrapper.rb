# frozen_string_literal: true

module RailsMiniProfiler
  class Request
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
      @env['REQUEST_PATH']
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
