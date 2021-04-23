# frozen_string_literal: true

module RailsMiniProfiler
  class Configuration
    attr_accessor :storage

    def initialize
      super
      @storage = Storage::Memory
    end
  end
end
