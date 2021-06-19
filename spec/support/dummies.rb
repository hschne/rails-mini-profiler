# frozen_string_literal: true

module Dummies
  class DummyRecord
    attr_accessor :id, :value

    def initialize(**kwargs)
      kwargs.each { |key, value| instance_variable_set("@#{key}", value) }
    end
  end
end
