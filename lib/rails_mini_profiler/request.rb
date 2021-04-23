# frozen_string_literal: true

module RailsMiniProfiler
  class Request
    def initialize(env)
      @env = env
    end

    def query_string
      @env['QUERY_STRING']
    end

    def path
      @env['PATH_INFO'].sub('//', '/')
    end
  end
end
