# frozen_string_literal: true

module RailsMiniProfiler
  class ApplicationRecord < ActiveRecord::Base
    self.abstract_class = true

    def self.record_timestamps
      # Some applications may disable timestamp setting, but in the context of the engine we always want to record
      # timestamps, as engine functionality relies on it.
      true
    end
  end
end
