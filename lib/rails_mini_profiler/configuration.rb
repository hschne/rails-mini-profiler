# frozen_string_literal: true

module RailsMiniProfiler
  class Configuration
    attr_accessor :storage, :skip_paths

    def initialize
      super
      reset
    end

    def reset
      @storage = Storage::Memory
      @skip_paths = []
    end
  end
end
