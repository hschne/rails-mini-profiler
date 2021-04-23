# frozen_string_literal: true

module RailsMiniProfiler
  class Configuration
    attr_accessor :storage

    attr_accessor :ignored_paths

    def initialize
      super
      reset
    end

    def reset
      @storage = Storage::Memory
      @ignored_paths = []
    end
  end
end
