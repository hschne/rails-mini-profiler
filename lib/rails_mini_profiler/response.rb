# frozen_string_literal: true

module RailsMiniProfiler
  class Response
    attr_reader :status, :headers, :response

    def initialize(**kwargs)
      kwargs.each { |key, value| instance_variable_set("@#{key}", value) }
    end
  end
end
