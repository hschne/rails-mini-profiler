# frozen_string_literal: true

module RailsMiniProfiler
  module Storage
    class Memory < BaseStorage
      class << self
        def configuration
          @configuration ||= Memory.new
        end
      end
    end
  end
end
