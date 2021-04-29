# frozen_string_literal: true

module RailsMiniProfiler
  class Trace
    attr_reader :name, :start, :finish, :duration, :payload, :backtrace

    def initialize(**kwargs)
      kwargs.each { |key, value| instance_variable_set("@#{key}", value) }
    end
  end
end
