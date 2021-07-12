# frozen_string_literal: true

module RailsMiniProfiler
  class RequestWrapper
    attr_reader :body,
                :method,
                :path,
                :query_string,
                :env

    def initialize(env = {})
      @env = env
      @method = @env['REQUEST_METHOD'] || 'GET'
      @query_string = @env['QUERY_STRING'] || ''
      @path = @env['PATH_INFO'] || '/'
      @body = @env['rack.input']&.read || ''
    end

    def headers
      @env.select { |k, _v| k.start_with? 'HTTP_' } || []
    end

    private

    def sanitize_headers(headers)
      headers.collect { |k, v| [k.sub(/^HTTP_/, ''), v] }.collect do |k, v|
        [k.split('_').collect(&:capitalize).join('-').to_sym, v]
      end
    end
  end
end
