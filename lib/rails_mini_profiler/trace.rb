# frozen_string_literal: true

module RailsMiniProfiler
  class Trace

    attr_reader :id, :name, :start, :finish, :duration, :payload

    def initialize(**kwargs)
      kwargs.each { |key, value| instance_variable_set("@#{key}", value) }
    end
  end
end
